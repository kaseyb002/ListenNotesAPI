//
//  LNError.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

public struct LNError: Error {
    let statusCode: Int?
    let type: ErrorType
    
    enum ErrorType {
        case missingAPIKey
        case notFound
        case unauthorized
        case serverError
        case badRequest
        case parsingError(String?)
        case badParameters
        case unknown
    }
}

extension LNError {
    
    private var devMessage: String {
        switch type {
        case .missingAPIKey:
            return "API Key has not been set"
        case .notFound:
            return "Not Found"
        case .unauthorized:
            return "Unauthorized"
        case .serverError:
            return "ListenNotes Server Error"
        case .badRequest:
            return "Bad Request"
        case .parsingError(let explanation):
            return explanation ?? "JSON parsing error"
        case .unknown:
            return "Unknown Failure"
        case .badParameters:
            return "Failed to encode parameters"
        }
    }
    
    public var message: String {
        if let statusCode = statusCode {
            return devMessage + " - "  + String(statusCode)
        }
        return devMessage
    }
}
