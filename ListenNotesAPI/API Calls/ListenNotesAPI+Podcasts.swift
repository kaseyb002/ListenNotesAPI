//
//  ListenNotesAPI+Podcasts.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/23/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

// MARK: Podcasts
extension ListenNotesAPI {
    
    public static func getPodcast(
        byId id: String,
        callback: @escaping (Result<LNPodcast, LNError>) -> ()
    ) {
        LNService.call(.getPodcast(podcastId: id), callback: callback)
    }
    
    public static func getPodcastsBatch(
        withIds ids: [String]? = nil,
        withRssUrls rssUrls: [String]? = nil,
        withiTunesIds iTunesIds: [Int]? = nil,
        callback: @escaping (Result<[LNPodcast], LNError>) -> ()
    ) {
        let params = LNPodcastBatchParams(ids: ids, rssUrls: rssUrls, iTunesIds: iTunesIds)
        let parse = convert(map: { (batch: LNPodcastBatch) in batch.podcasts },
                            callback: callback)
        LNService.call(.getPodcastsBatch,
                       parameters: params.params,
                       callback: parse)
    }
}

extension ListenNotesAPI {
    
    private struct LNPodcastBatchParams: Encodable {
        let ids: [String]?
        let rssUrls: [String]?
        let iTunesIds: [Int]?
        
        enum CodingKeys: String, CodingKey {
            case ids
            case rssUrls = "rsses"
            case iTunesIds = "itunes_ids"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            if let idsString = ids?.joined(separator: ",") {
                try container.encode(idsString, forKey: .ids)
            }
            if let rssesString = rssUrls?.joined(separator: ",") {
                try container.encode(rssesString, forKey: .rssUrls)
            }
            if let itunesString = iTunesIds?.map({ String($0) }).joined(separator: ",") {
                try container.encode(itunesString, forKey: .iTunesIds)
            }
        }
        
        var params: [String: Any] {
            var dict = [String: Any]()
            
            if let idsString = ids?.joined(separator: ",") {
                dict[CodingKeys.ids.rawValue] = idsString
            }
            
            if let rssesString = rssUrls?.joined(separator: ",") {
                dict[CodingKeys.rssUrls.rawValue] = rssesString
            }
            
            if let itunesString = iTunesIds?.map({ String($0) }).joined(separator: ",") {
                dict[CodingKeys.iTunesIds.rawValue] = itunesString
            }
            
            return dict
        }
    }
    
    private struct LNPodcastBatch: Codable {
        let podcasts: [LNPodcast]
    }
}
