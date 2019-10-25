//
//  Convert.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/23/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

/// Convert helper response model into final model for client
func convert<T: Decodable, U>(map: @escaping (T) -> (U),
                              callback: @escaping ((Result<U, LNError>) -> ())) -> (Result<T, LNError>) -> () {
    let parse: (Result<T, LNError>) -> () = { result in
        switch result {
        case .success(let genresResponse):
            let finalObject = map(genresResponse)
            callback(.success(finalObject))
        case .failure(let error):
            callback(.failure(error))
        }
    }
    return parse
}
