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
    
    /**
    Full-text search on podcasts
    
    - Parameter withText: Text to search with.
     
    - Parameter filter: Add an optional filter to curate results.
    */
    public static func searchPodcasts(
        with text: String,
        filter: LNSearchFilter? = nil,
        offset: Int? = nil,
        callback: @escaping (Result<LNPodcastResults, LNError>) -> ()
    ) {
        let params = LNSearchParams(q: text,
                                    type: .podcasts,
                                    offset: offset,
                                    filter: filter)
        LNService.call(.search,
                       parameters: params.params,
                       callback: callback)
    }
    
    /**
    Full-text search on episodes
    
    - Parameter withText: Text to search with.
     
    - Parameter filter: Add an optional filter to curate results.
    */
    public static func searchEpisodes(
        with text: String,
        filter: LNSearchFilter? = nil,
        offset: Int? = nil,
        callback: @escaping (Result<LNEpisodeResults, LNError>) -> ()
    ) {
        let params = LNSearchParams(q: text,
                                    type: .episodes,
                                    offset: offset,
                                    filter: filter)
        LNService.call(.search,
                       parameters: params.params,
                       callback: callback)
    }
    
    /**
    Get search suggestions based on search text
    
    - Parameter withText: Text to search with.
     
    - Parameter includePodcasts: Include podcast suggestions.
     Note: This only searches podcast title and publisher
     and returns very limited info of 5 podcasts.
     It's a bit slow to autosuggest podcasts,
     so it's off by default. If `includePodcasts` is `true`,
     you can also pass iTunes id (e.g., 474722933)
     to the text parameter to fetch podcast meta data.
     
    - Parameter includeGenres: Include genre suggestions
     
    - Parameter filterExplicit: Exclude results with explicit content.
     Note: Only works when `includePodcasts` is `true`.
    */
    public static func typehead(
        with text: String,
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

// MARK: Helper Models
extension ListenNotesAPI {
    
    private struct LNSearchParams {
        let q: String
        let type: MediaType
        let offset: Int?
        let filter: LNSearchFilter?
        
        enum MediaType: String {
            case podcasts = "podcast"
            case episodes = "episode"
        }
        
        enum CodingKeys: String, CodingKey {
            case q
            case type
            case offset
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
        
        var params: [String: Any] {
            var dict = [String: Any]()
            dict[CodingKeys.q.rawValue] = q
            dict[CodingKeys.type.rawValue] = type.rawValue
            offset.map {
                dict[CodingKeys.offset.rawValue] = $0
            }
            
            guard let filter = filter else { return dict }
            
            switch filter.sortBy {
            case .relevance:
                break
            case .mostRecent:
                dict[CodingKeys.sortBy.rawValue] = filter.sortBy.rawValue
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
            
            switch filter.safeMode {
            case .off:
                break
            case .filterExplicit:
                dict[CodingKeys.safeMode.rawValue] = filter.safeMode.rawValue
            }
            
            return dict
        }
    }
    
    
    private struct LNTypeheadParams {
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
        
        var params: [String: Any] {
            var dict = [String: Any]()
            dict[CodingKeys.q.rawValue] = q.lowercased()
            dict[CodingKeys.includePodcasts.rawValue] = includePodcasts ? 1 : 0
            dict[CodingKeys.includeGenres.rawValue] = includeGenres ? 1 : 0
            dict[CodingKeys.filterExplicit.rawValue] = filterExplicit ? 1 : 0
            return dict
        }
    }
}
