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
    
    /**
    Fetch a podcast by ListenNotes `id`
    
    - Parameter byId: ListenNotes `id` of the podcast you want.
    */
    public static func getPodcast(
        byId id: String,
        callback: @escaping (Result<LNPodcast, LNError>) -> ()
    ) {
        LNService.call(.getPodcast(podcastId: id), callback: callback)
    }
    
    /**
    Batch fetch for up to 10 podcasts
    
    - Parameter withIds: ListenNotes `id`s of the podcasts you want.
     
    - Parameter withRssUrls: RSS urls  of the podcasts you want. Useful for importing.
     
    - Parameter withiTunesIds: iTunes `id`s of the podcasts you want.
    */
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
    
    /**
    Get the most popular podcasts
     
    - Parameter byGenreId: Get most popular for specific genre.
     
    - Parameter page: The paged index of results
     
    - Parameter regionCode: Restrict results to a specific region.
     
    - Parameter filterExplicit: Exclude explicit podcasts; off by default.
    */
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
    
    /**
     Fetch up to 8 podcast recommendations based on the podcast id.
     
     */
    public static func getSimilarPodcasts(
        podcastId: String,
        callback: @escaping (Result<[LNPodcast], LNError>) -> ()
    ) {
        let parse = convert(map: { (batch: LNSimilarPodcastsBatch) in batch.recommendations },
                            callback: callback)
        
        LNService.call(.podcastRecommendations(podcastId: podcastId),
                       callback: parse)
    }
}

// MARK: Helper Models
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
    
    private struct LNSimilarPodcastsBatch: Codable {
        let recommendations: [LNPodcast]
    }
}
