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
    let email: String?
    let image: URL
    let title: String
    let genreIds: [Int]
    let iTunesId: Int
    let publisher: String
    let thumbnail: String
    let description: String
    let totalEpisodes: Int
    let listenNotesUrl: URL
    let explicitContent: Bool
    let latestPubDateMs: Double
    let earliestPubDateMs: Double
    let extra: LNPodcastExtras?
    
    enum CodingKeys: String, CodingKey {
        case id
        case image
        case latestPubDateMs = "lastest_pub_date_ms"
        case earliestPubDateMs = "earliest_pub_date_ms"
        case rss
        case explicitContent = "explicit_content"
        case genreIds = "genre_ids"
        case thumbnail
        case totalEpisodes = "total_episodes"
        case listenNotesUrl = "listennotes_url"
        case iTunesId = "itunes_id"
        case email
        case extra
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        rss = try values.decode(URL.self, forKey: .rss)
        email = try values.decode(String?.self, forKey: .email)
        image = try values.decode(URL.self, forKey: .image)
        title = try LNPodcast.parseTitle(from: decoder)
        genreIds = try values.decode([Int].self, forKey: .genreIds)
        iTunesId = try values.decode(Int.self, forKey: .iTunesId)
        publisher = try LNPodcast.parsePublisher(from: decoder)
        thumbnail = try values.decode(String.self, forKey: .thumbnail)
        description = try LNPodcast.parseDescription(from: decoder)
        totalEpisodes = try values.decode(Int.self, forKey: .totalEpisodes)
        listenNotesUrl = try values.decode(URL.self, forKey: .listenNotesUrl)
        explicitContent = try values.decode(Bool.self, forKey: .explicitContent)
        latestPubDateMs = try values.decode(Double.self, forKey: .latestPubDateMs)
        earliestPubDateMs = try values.decode(Double.self, forKey: .earliestPubDateMs)
        extra = try values.decodeIfPresent(LNPodcastExtras.self, forKey: .extra)
    }
}

// MARK: Title, Description, & Publisher Parsing
extension LNPodcast {
    
    enum NormalKeys: String, CodingKey {
        case title
        case publisher
        case description
    }
    
    enum AltKeys: String, CodingKey {
        case titleOriginal = "title_original"
        case publisherOriginal = "publisher_original"
        case descriptionOriginal = "description_original"
    }
    
    static func parseTitle(from decoder: Decoder) throws -> String {
        if
            let values = try? decoder.container(keyedBy: NormalKeys.self),
            let value = try? values.decode(String.self, forKey: .title) {
            return value
        }
        
        let values = try decoder.container(keyedBy: AltKeys.self)
        return try values.decode(String.self, forKey: .titleOriginal)
    }
    
    static func parseDescription(from decoder: Decoder) throws -> String {
        if
            let values = try? decoder.container(keyedBy: NormalKeys.self),
            let value = try? values.decode(String.self, forKey: .description) {
            return value
        }
        
        let values = try decoder.container(keyedBy: AltKeys.self)
        return try values.decode(String.self, forKey: .descriptionOriginal)
    }
    
    static func parsePublisher(from decoder: Decoder) throws -> String {
        if
            let values = try? decoder.container(keyedBy: NormalKeys.self),
            let value = try? values.decode(String.self, forKey: .publisher) {
            return value
        }
        
        let values = try decoder.container(keyedBy: AltKeys.self)
        return try values.decode(String.self, forKey: .publisherOriginal)
    }
}
