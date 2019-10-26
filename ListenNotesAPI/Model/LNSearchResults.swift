//
//  LNSearchResults.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

public struct LNPodcastResults: Codable {
    let count: Int
    let took: TimeInterval
    let total: Int
    let podcasts: [LNPodcast]
    let nextOffset: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case took
        case total
        case podcasts = "results"
        case nextOffset = "next_offset"
    }
}

public struct LNEpisodeResults: Decodable {
    let count: Int
    let took: TimeInterval
    let total: Int
    let episodes: [LNEpisode]
    let nextOffset: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case took
        case total
        case episodes = "results"
        case nextOffset = "next_offset"
    }
}
