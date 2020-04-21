//
//  LNEpisode.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

public struct LNEpisode: Decodable {
    public let id: String
    public let title: String
    public let description: String
    public let publisher: String?
    public let audio: URL
    public let image: URL?
    public let thumbnail: URL?
    public let pubDateMs: Int
    public let listenNotesUrl: URL
    public let audioLength: TimeInterval
    public let explicitContent: Bool
    public let podcastId: String
    public let podcastTitle: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case audio
        case image
        case thumbnail
        case pubDateMs = "pub_date_ms"
        case listenNotesUrl = "listennotes_url"
        case audioLength = "audio_length_sec"
        case explicitContent = "explicit_content"
        case extras
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try LNEpisode.parseTitle(from: decoder)
        description = try LNEpisode.parseDescription(from: decoder)
        publisher = try LNEpisode.parsePublisher(from: decoder)
        audio = try values.decode(URL.self, forKey: .audio)
        let imageString = try values.decode(String.self, forKey: .image)
        image = URL(string: imageString)
        let thumbnailString = try values.decode(String.self, forKey: .thumbnail)
        thumbnail = URL(string: thumbnailString)
        pubDateMs = try values.decode(Int.self, forKey: .pubDateMs)
        listenNotesUrl = try values.decode(URL.self, forKey: .listenNotesUrl)
        audioLength = try values.decode(TimeInterval.self, forKey: .audioLength)
        explicitContent = try values.decode(Bool.self, forKey: .explicitContent)
        podcastId = try LNEpisode.parsePodcastId(from: decoder)
        podcastTitle = try LNEpisode.parsePodcastTitle(from: decoder)
    }
}

// MARK: Title, Description, & Publisher Parsing
extension LNEpisode {
    
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
    
    static func parsePublisher(from decoder: Decoder) throws -> String? {
        if
            let values = try? decoder.container(keyedBy: NormalKeys.self),
            let value = try? values.decode(String.self, forKey: .publisher) {
            return value
        }
        
        if
            let values = try? decoder.container(keyedBy: PodcastKey.self),
            let podcast = try? values.decode(LNPodcast.self, forKey: .podcast) {
            return podcast.publisher
        }
        
        let values = try decoder.container(keyedBy: AltKeys.self)
        return try? values.decode(String.self, forKey: .publisherOriginal)
    }
}

// MARK: Podcast Data Parsing
extension LNEpisode {
    
    enum PodcastKey: String, CodingKey {
        case podcast
    }
    
    enum PodcastAltKeys: String, CodingKey {
        case podcastId = "podcast_id"
        case podcastTitle = "podcast_title"
    }
    
    enum PodcastAlt2ndKeys: String, CodingKey {
        case podcastId = "podcast_id"
        case podcastTitleOriginal = "podcast_title_original"
    }
    
    static func parsePodcastId(from decoder: Decoder) throws -> String {
        if
            let values = try? decoder.container(keyedBy: PodcastAltKeys.self),
            let podcastId = try? values.decode(String.self, forKey: .podcastId) {
            return podcastId
        }
        
        if
            let values = try? decoder.container(keyedBy: PodcastAlt2ndKeys.self),
            let podcastId = try? values.decode(String.self, forKey: .podcastId) {
            return podcastId
        }
        
        let values = try decoder.container(keyedBy: PodcastKey.self)
        let podcast = try values.decode(LNPodcast.self, forKey: .podcast)
        return podcast.id
    }
    
    static func parsePodcastTitle(from decoder: Decoder) throws -> String {
        if
            let values = try? decoder.container(keyedBy: PodcastAltKeys.self),
            let podcastId = try? values.decode(String.self, forKey: .podcastTitle) {
            return podcastId
        }
        
        if
            let values = try? decoder.container(keyedBy: PodcastAlt2ndKeys.self),
            let podcastId = try? values.decode(String.self, forKey: .podcastTitleOriginal) {
            return podcastId
        }
        
        let values = try decoder.container(keyedBy: PodcastKey.self)
        let podcast = try values.decode(LNPodcast.self, forKey: .podcast)
        return podcast.title
    }
}
