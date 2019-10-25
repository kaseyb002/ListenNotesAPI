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
    
    public static func getBestPodcasts(
        byGenreId genreId: Int? = nil,
        page: Int? = nil,
        regionCode: String? = nil,
        filterExplicit: Bool = false,
        callback: @escaping (Result<LNBestPodcasts, LNError>) -> ()
    ) {
        let params = LNBestPodcastParams(genreId: genreId,
                                         page: page,
                                         regionCode: regionCode,
                                         filterExplicit: filterExplicit)
        LNService.call(.bestPodcasts,
                       parameters: params.params,
                       callback: callback)
    }
}

extension ListenNotesAPI {
    
    private struct LNPodcastBatchParams {
        let ids: [String]?
        let rssUrls: [String]?
        let iTunesIds: [Int]?
        
        enum CodingKeys: String, CodingKey {
            case ids
            case rssUrls = "rsses"
            case iTunesIds = "itunes_ids"
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
    
    private struct LNBestPodcastParams {
        let genreId: Int?
        let page: Int?
        let regionCode: String?
        let filterExplicit: Bool
        
        enum CodingKeys: String, CodingKey {
            case genreId = "genre_id"
            case page
            case regionCode = "region_code"
            case filterExplicit = "safe_mode"
        }
        
        var params: [String: Any] {
            var dict = [String: Any]()
            
            genreId.map {
                dict[CodingKeys.genreId.rawValue] = String($0)
            }
            
            page.map {
                dict[CodingKeys.page.rawValue] = String($0)
            }
            
            regionCode.map {
                dict[CodingKeys.regionCode.rawValue] = $0
            }
            
            if filterExplicit {
                dict[CodingKeys.filterExplicit.rawValue] = filterExplicit
            }
            
            return dict
        }
    }
}
