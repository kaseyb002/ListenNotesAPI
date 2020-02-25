//
//  ListenNotesAPI+Regions.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/23/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

// MARK: API Calls
extension ListenNotesAPI {
    
    /**
    Fetch full list of support regions with region codes.
    
    */
    public static func getRegions(callback: @escaping (Result<[LNRegion], LNError>) -> ()) {
        let parse: (Result<LNRegionsResponse, LNError>) -> () = { result in
            callback(result.map {
                $0.regions.map( { (key, value) in LNRegion(code: key, name: value) })
            })
        }
        LNService.call(.regions, callback: parse)
    }
}

// MARK: Helper Models
extension ListenNotesAPI {
    
    private struct LNRegionsResponse: Codable {
        let regions: [String: String]
    }
}
