//
//  LNSearchResults.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

public struct LNPodcastResults: Codable {
    public let count: Int
    public let took: TimeInterval
    public let total: Int
    public let podcasts: [LNPodcast]
    public let nextOffset: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case took
        case total
        case podcasts = "results"
        case nextOffset = "next_offset"
    }
}

public struct LNEpisodeResults: Decodable {
    public let count: Int
    public let took: TimeInterval
    public let total: Int
    public let episodes: [LNEpisode]
    public let nextOffset: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case took
        case total
        case episodes = "results"
        case nextOffset = "next_offset"
    }
}
