//
//  ListenNotesAPI+Episodes.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/23/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

// MARK: API Calls
extension ListenNotesAPI {
    
    /**
     Fetch data for an episode by id
     
     - Parameter id: ListenNotes `id` of the episode you want.
     */
    public static func getEpisode(
        byId id: String,
        callback: @escaping (Result<LNEpisode, LNError>) -> ()
    ) {
        LNService.call(.getEpisode(episodeId: id), callback: callback)
    }
    
    /**
     Batch fetch data for up to 10 episodes
     
     This endpoint could be used to implement custom playlists for individual episodes.
     
     - Parameter ids: ListenNotes `id`s of the episodes you want.
     */
    public static func getEpisodesBatch(
        withIds ids: [String],
        callback: @escaping (Result<[LNEpisode], LNError>) -> ()
    ) {
        
        let params = LNEpisodeBatchParams(ids: ids)
        
        let parse = convert(map: { (batch: LNEpisodeBatch) in batch.episodes},
                            callback: callback)
        LNService.call(.getEpisodesBatch,
                       parameters: .init(params),
                       callback: parse)
    }
    
    /**
     Fetch a random podcast episode.
     
     Recently published episodes are more likely to be fetched. Good luck!
     */
    public static func justListen(callback: @escaping (Result<LNEpisode, LNError>) -> ()) {
        LNService.call(.justListen, callback: callback)
    }
}

// MARK: Helper Structs
extension ListenNotesAPI {
    
    private struct LNEpisodeBatch: Decodable {
        let episodes: [LNEpisode]
    }
    
    private struct LNEpisodeBatchParams: Encodable {
        let ids: [String]
        
        enum CodingKeys: String, CodingKey {
            case ids
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let idsString = ids.joined(separator: ",")
            try container.encode(idsString, forKey: .ids)
        }
    }
}
