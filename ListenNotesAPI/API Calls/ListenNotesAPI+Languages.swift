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
    
    public static func getLanguages(callback: @escaping (Result<[String], LNError>) -> ()) {
        
        let parse = convert(map: { (response: LNLanguagesResponse) in response.languages },
                            callback: callback)
        
        LNService.call(.languages, callback: parse)
    }
}

// MARK: Helper Models
extension ListenNotesAPI {
    
    private struct LNLanguagesResponse: Codable {
        let languages: [String]
    }
}
