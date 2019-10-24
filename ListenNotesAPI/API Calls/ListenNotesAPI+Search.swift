//
//  ListenNotesAPI+Search.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/23/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

// MARK: API Calls
extension ListenNotesAPI {
    
    public static func searchPodcasts(
        withText text: String,
        filter: LNSearchFilter? = nil,
        callback: @escaping (Result<LNPodcastResults, LNError>) -> ()
    ) {
        let params = LNSearchParams(q: text, type: .podcasts, filter: filter)
        LNService.call(.search,
                       parameters: params.params,
                       callback: callback)
    }
    
    public static func searchEpisodes(
        withText text: String,
        filter: LNSearchFilter? = nil,
        callback: @escaping (Result<LNEpisodeResults, LNError>) -> ()
    ) {
        let params = LNSearchParams(q: text, type: .episodes, filter: filter)
        LNService.call(.search,
                       parameters: params.params,
                       callback: callback)
    }
    
    public static func typehead(
        withText text: String,
        includePodcasts: Bool = false,
        includeGenres: Bool = false,
        filterExplicit: Bool = false,
        callback: @escaping (Result<LNTypeahead, LNError>) -> ()
    ) {
        let params = LNTypeheadParams(q: text,
                                     includePodcasts: includePodcasts,
                                     includeGenres: includeGenres,
                                     filterExplicit: filterExplicit)
        
        LNService.call(.typeahead,
                       parameters: params.params,
                       callback: callback)
    }
}

// MARK: Helper Structs
extension ListenNotesAPI {
    
    private struct LNSearchParams: Encodable {
        let q: String
        let type: MediaType
        let filter: LNSearchFilter?
        
        enum MediaType: String {
            case podcasts = "podcast"
            case episodes = "episode"
        }
        
        enum CodingKeys: String, CodingKey {
            case q
            case type
            case sortBy = "sort_by_date"
            case searchInFields = "only_in"
            case minMinuteLength = "len_min"
            case maxMinuteLength = "len_max"
            case publishedAfter = "published_after"
            case publishedBefore = "published_before"
            case safeMode = "safe_mode"
            case language
            case genreIds = "genre_ids"
            case podcastId = "ocid"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(q, forKey: .q)
            try container.encode(type.rawValue, forKey: .type)
            guard let filter = filter else { return }
            try filter.sortBy.map {
                switch $0 {
                case .relevance:
                    break
                case .mostRecent:
                    try container.encode($0.rawValue, forKey: .sortBy)
                }
            }
            
            if !filter.searchInFields.contains(.everything), !filter.searchInFields.isEmpty {
                let searchFields = filter.searchInFields.map { $0.rawValue }.joined(separator: ",")
                try container.encode(searchFields, forKey: .searchInFields)
            }
            
            try filter.minMinuteLength.map {
                try container.encode($0, forKey: .minMinuteLength)
            }
            
            try filter.minMinuteLength.map {
                try container.encode($0, forKey: .maxMinuteLength)
            }
            
            try filter.language.map {
                try container.encode($0, forKey: .language)
            }
            
            if !filter.genreIds.isEmpty {
                let ids = filter.genreIds.map { "\($0)" }.joined(separator: ",")
                try container.encode(ids, forKey: .genreIds)
            }
            
            try filter.podcastId.map {
                try container.encode($0, forKey: .podcastId)
            }
            
            try filter.safeMode.map {
                switch $0 {
                case .off:
                    break
                case .filterExplicit:
                    try container.encode($0.rawValue, forKey: .safeMode)
                }
            }
        }
        
        var params: [String: Any] {
            var dict = [String: Any]()
            dict[CodingKeys.q.rawValue] = q
            dict[CodingKeys.type.rawValue] = type.rawValue
            
            guard let filter = filter else { return dict }
            
            filter.sortBy.map {
                switch $0 {
                case .relevance:
                    break
                case .mostRecent:
                    dict[CodingKeys.sortBy.rawValue] = $0.rawValue
                }
            }
            
            if !filter.searchInFields.contains(.everything), !filter.searchInFields.isEmpty {
                let searchFields = filter.searchInFields.map { $0.rawValue }.joined(separator: ",")
                dict[CodingKeys.searchInFields.rawValue] = searchFields
            }
            
            filter.minMinuteLength.map {
                dict[CodingKeys.minMinuteLength.rawValue] = $0
            }
            
            filter.minMinuteLength.map {
                dict[CodingKeys.maxMinuteLength.rawValue] = $0
            }
            
            filter.language.map {
                dict[CodingKeys.language.rawValue] = $0
            }
            
            if !filter.genreIds.isEmpty {
                let ids = filter.genreIds.map { "\($0)" }.joined(separator: ",")
                dict[CodingKeys.genreIds.rawValue] = ids
            }
            
            filter.podcastId.map {
                dict[CodingKeys.podcastId.rawValue] = $0
            }
            
            filter.safeMode.map {
                switch $0 {
                case .off:
                    break
                case .filterExplicit:
                    dict[CodingKeys.safeMode.rawValue] = $0.rawValue
                }
            }
            return dict
        }
    }
    
    
    private struct LNTypeheadParams: Encodable {
        let q: String
        let includePodcasts: Bool
        let includeGenres: Bool
        let filterExplicit: Bool
        
        enum CodingKeys: String, CodingKey {
            case q
            case includePodcasts = "show_podcasts"
            case includeGenres = "show_genres"
            case filterExplicit = "safe_mode"
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(q, forKey: .q)
            try container.encode(includePodcasts ? 1 : 0,
                                 forKey: .includePodcasts)
            try container.encode(includeGenres ? 1 : 0,
                                 forKey: .includeGenres)
            try container.encode(filterExplicit ? 1 : 0,
                                 forKey: .filterExplicit)
        }
        
        var params: [String: Any] {
            var dict = [String: Any]()
            dict[CodingKeys.q.rawValue] = q
            dict[CodingKeys.includePodcasts.rawValue] = includePodcasts ? 1 : 0
            dict[CodingKeys.includeGenres.rawValue] = includeGenres ? 1 : 0
            dict[CodingKeys.filterExplicit.rawValue] = filterExplicit ? 1 : 0
            return dict
        }
    }
}
