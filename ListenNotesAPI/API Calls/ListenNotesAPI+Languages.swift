//
//  ListenNotesAPI+Languages.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/23/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

// MARK: API Calls
extension ListenNotesAPI {
    
    /**
    Fetch full list of support languages.
    
    */
    public static func getLanguages(callback: @escaping (Result<[String], LNError>) -> ()) {
        let parse: (Result<LNLanguagesResponse, LNError>) -> () = { result in
            callback(result.map { $0.languages })
        }
        LNService.call(.languages, callback: parse)
    }
}

// MARK: Helper Models
extension ListenNotesAPI {
    
    private struct LNLanguagesResponse: Codable {
        let languages: [String]
    }
}
