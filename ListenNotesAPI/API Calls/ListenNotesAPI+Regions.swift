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
    
    public static func getRegions(callback: @escaping (Result<[LNRegion], LNError>) -> ()) {
        
        let parse = convert(
            map: { (response: LNRegionsResponse) in
                response.regions.map( { (key, value) in LNRegion(code: key, name: value) })
            },
            callback: callback)
        
        LNService.call(.regions, callback: parse)
    }
}

// MARK: Helper Models
extension ListenNotesAPI {
    
    private struct LNRegionsResponse: Codable {
        let regions: [String: String]
    }
}
