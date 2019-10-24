//
//  LNService.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

final class LNService {}

extension LNService {
    
    static func call<T: Decodable>(_ endpoint: LNEndpoint,
                                   parameters: AnyEncodable? = nil,
                                   callback: @escaping (Result<T, LNError>) -> ()) {
        precondition(ListenNotesAPI.Config.hasSetApiKey,
                     "ListenNotesAPI Key has not been set. Call with ListenNotesAPI.Config.set(apiKey: String)")
        
        guard let apiKey = ListenNotesAPI.Config.apiKey else {
            fatalError("Accessing ListenNotesAPI.Config.apiKey before it has been set.")
        }
        
        var req = URLRequest(url: endpoint.url,
                             cachePolicy: .returnCacheDataElseLoad,
                             timeoutInterval: 60)
        
        req.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        req.setValue(apiKey, forHTTPHeaderField: "X-ListenAPI-Key")
        req.httpMethod = endpoint.method.rawValue
        do {
            try req.add(parameters: parameters, method: endpoint.method)
        } catch {
            callback(.failure(LNError(statusCode: nil, type: .badParameters)))
            return
        }
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            parse(response: response, data: data, error: error, callback: callback)
        }.resume()
    }
}

// MARK: Parse Response
extension LNService {
    
    private static func parse<T: Decodable>(response: URLResponse?,
                                            data: Data?,
                                            error: Error?,
                                            callback: @escaping (Result<T, LNError>) -> ()) {
        guard let http = response as? HTTPURLResponse else {
            DispatchQueue.main.async {
                callback(.failure(LNError(statusCode: nil, type: .unknown)))
            }
            return
        }
        
        switch http.statusCode {
        case 200:
            guard let data = data else {
                DispatchQueue.main.async {
                    callback(.failure(.init(statusCode: http.statusCode, type: .notFound)))
                }
                return
            }
            
            do {
                let instance = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    callback(.success(instance))
                }
            } catch let error {
                DispatchQueue.main.async {
                    callback(.failure(.init(statusCode: http.statusCode,
                                            type: .parsingError(error.localizedDescription))))
                }
            }
            
        case 401:
            callback(.failure(.init(statusCode: http.statusCode, type: .unauthorized)))
        case 404:
            DispatchQueue.main.async {
                callback(.failure(.init(statusCode: http.statusCode, type: .notFound)))
            }
        case 500...599:
            DispatchQueue.main.async {
                callback(.failure(.init(statusCode: http.statusCode, type: .serverError)))
            }
        default:
            DispatchQueue.main.async {
                callback(.failure(.init(statusCode: http.statusCode, type: .unknown)))
            }
        }
    }
}

// MARK: Encode Parameters
extension URLRequest {
    
    mutating func add(parameters: AnyEncodable?, method: HTTPMethod) throws {
        guard let parameters = parameters else { return }
        switch method {
        case .get:
            break
        case .post:
            let encoder = JSONEncoder()
            httpBody = try encoder.encode(parameters)
        }
    }
}

// MARK: Encode Parameters
struct AnyEncodable: Encodable {

    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }

    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
