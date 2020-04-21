//
//  Endpoint.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

enum LNEndpoint {
    case getPodcast(podcastId: String)
    case getEpisode(episodeId: String)
    case getPodcastsBatch
    case getEpisodesBatch
    case bestPodcasts
    case typeahead
    case search
    case genres
    case regions
    case languages
    case justListen
    case podcastRecommendations(podcastId: String)
    case episodeRecommendations(episodeId: String)
}

extension LNEndpoint {
        
    var baseUrl: String { "https://listen-api.listennotes.com/api/v2" }
    
    var url: URL { URL(string: baseUrl + path)! }
    
    var path: String {
        switch self {
        case .getPodcast(let podcastId):
            return "/podcasts/\(podcastId)"
        case .getEpisode(let episodeId):
            return "/episodes/\(episodeId)"
        case .bestPodcasts:
            return "/best_podcasts"
        case .typeahead:
            return "/typeahead"
        case .search:
            return "/search"
        case .genres:
            return "/genres"
        case .regions:
            return "/regions"
        case .languages:
            return "/languages"
        case .justListen:
            return "/just_listen"
        case .podcastRecommendations(let podcastId):
            return "/podcasts/\(podcastId)/recommendations"
        case .episodeRecommendations(let episodeId):
            return "/episodes/\(episodeId)/recommendations"
        case .getPodcastsBatch:
            return "/podcasts"
        case .getEpisodesBatch:
            return "/episodes"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPodcast,
             .getEpisode,
             .bestPodcasts,
             .typeahead,
             .search,
             .genres,
             .regions,
             .languages,
             .justListen,
             .podcastRecommendations,
             .episodeRecommendations:
            return .get
        case .getPodcastsBatch,
             .getEpisodesBatch:
            return .post
        }
    }
}
