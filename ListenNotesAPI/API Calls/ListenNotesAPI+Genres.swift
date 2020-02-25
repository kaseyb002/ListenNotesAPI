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
        let parse: (Result<LNGenresResponse, LNError>) -> () = { result in
            callback(result.map { $0.genres })
        }
        LNService.call(.genres, callback: parse)
    }
}

// MARK: Helper Models
extension ListenNotesAPI {
    
    private struct LNGenresResponse: Decodable {
        let genres: [LNGenre]
    }
}
