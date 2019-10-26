//
//  ListenNotesAPI+Genres.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/23/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

// MARK: API Calls
extension ListenNotesAPI {
    
    /**
    Fetch full list of podcast genres.
    
    */
    public static func getGenres(callback: @escaping (Result<[LNGenre], LNError>) -> ()) {
        
        let parse = convert(map: { (response: LNGenresResponse) in response.genres },
                            callback: callback)
        
        LNService.call(.genres, callback: parse)
    }
}

// MARK: Helper Models
extension ListenNotesAPI {
    
    private struct LNGenresResponse: Decodable {
        let genres: [LNGenre]
    }
}
