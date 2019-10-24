//
//  LNPodcast.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

public struct LNPodcast: Codable {
    let id: String
    let rss: URL
    let email: String
    let image: URL
    let title: String
    let country: String
    let language: String
    let genreIds: [Int]
    let iTunesId: Int
    let publisher: String
    let thumbnail: String
    let isClaimed: Bool
    let description: String
    let totalEpisodes: Int
    let listenNotesUrl: URL
    let explicitContent: Bool
    let latestPubDateMs: Double
    let earliestPubDateMs: Double
    let extra: LNPodcastExtras
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case image
        case latestPubDateMs = "lastest_pub_date_ms"
        case earliestPubDateMs = "earliest_pub_date_ms"
        case rss
        case explicitContent = "explicit_content"
        case genreIds = "genre_ids"
        case publisher
        case thumbnail
        case totalEpisodes = "total_episodes"
        case listenNotesUrl = "listennotes_url"
        case iTunesId = "itunes_id"
        case isClaimed = "is_claimed"
        case country
        case language
        case email
        case extra
    }
}
