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
     Fetch an episode by ListenNotes `id`
     
     - Parameter byId: ListenNotes `id` of the episode you want.
     */
    public static func getEpisode(
        byId id: String,
        callback: @escaping (Result<LNEpisode, LNError>) -> ()
    ) {
        LNService.call(.getEpisode(episodeId: id), callback: callback)
    }
    
    /**
     Batch fetch for up to 10 episodes
     
     This endpoint could be used to implement custom playlists for individual episodes.
     
     - Parameter withIds: ListenNotes `id`s of the episodes you want.
     */
    public static func getEpisodesBatch(
        withIds ids: [String],
        callback: @escaping (Result<[LNEpisode], LNError>) -> ()
    ) {
        
        let params = LNEpisodeBatchParams(ids: ids)
        
        let parse = convert(map: { (batch: LNEpisodeBatch) in batch.episodes},
                            callback: callback)
        LNService.call(.getEpisodesBatch,
                       parameters: params.params,
                       callback: parse)
    }
    
    /**
     Fetch a random podcast episode.
     
     Recently published episodes are more likely to be fetched. Good luck!
     */
    public static func justListen(callback: @escaping (Result<LNEpisode, LNError>) -> ()) {
        LNService.call(.justListen, callback: callback)
    }
    
    /**
     Fetch up to 8 episode recommendations based on the episode id.
     
     */
    public static func getSimilarEpisodes(
        episodeId: String,
        callback: @escaping (Result<[LNEpisode], LNError>) -> ()
    ) {
        
        let parse = convert(map: { (batch: LNSimilarEpisodesBatch) in batch.recommendations },
                            callback: callback)
        
        LNService.call(.episodeRecommendations(episodeId: episodeId),
                       callback: parse)
    }
}

// MARK: Helper Models
extension ListenNotesAPI {
    
    private struct LNEpisodeBatch: Decodable {
        let episodes: [LNEpisode]
    }
    
    private struct LNEpisodeBatchParams {
        let ids: [String]
        
        enum CodingKeys: String, CodingKey {
            case ids
        }
        
        var params: [String: Any] {
            return [CodingKeys.ids.rawValue: ids.joined(separator: ",")]
        }
    }
    
    private struct LNSimilarEpisodesBatch: Decodable {
        let recommendations: [LNEpisode]
    }
}
