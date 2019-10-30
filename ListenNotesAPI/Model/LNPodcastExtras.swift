//
//  LNPodcastExtras.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

public struct LNPodcastExtras: Codable {
    public let url1: URL?
    public let url2: URL?
    public let url3: URL?
    public let googleUrl: URL?
    public let spotifyUrl: URL?
    public let youtubeUrl: URL?
    public let linkedInUrl: URL?
    public let weChatUrl: URL?
    public let patreonHandle: String?
    public let twitterHandle: String?
    public let facebookHandle: String?
    public let instagramHandle: String?
    
    enum CodingKeys: String, CodingKey {
        case url1
        case url2
        case url3
        case googleUrl = "google_url"
        case spotifyUrl = "spotify_url"
        case youtubeUrl = "youtube_url"
        case linkedInUrl = "linkedin_url"
        case weChatUrl = "wechat_handle"
        case patreonHandle = "patreon_handle"
        case twitterHandle = "twitter_handle"
        case facebookHandle = "facebook_handle"
        case instagramHandle = "instagram_handle"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url1 = try values.decode(String?.self, forKey: .url1)?.asUrl
        url2 = try values.decode(String?.self, forKey: .url2)?.asUrl
        url3 = try values.decode(String?.self, forKey: .url3)?.asUrl
        googleUrl = try values.decode(String?.self, forKey: .googleUrl)?.asUrl
        spotifyUrl = try values.decode(String?.self, forKey: .spotifyUrl)?.asUrl
        youtubeUrl = try values.decode(String?.self, forKey: .youtubeUrl)?.asUrl
        linkedInUrl = try values.decode(String?.self, forKey: .linkedInUrl)?.asUrl
        weChatUrl = try values.decode(String?.self, forKey: .weChatUrl)?.asUrl
        patreonHandle = try values.decode(String?.self, forKey: .patreonHandle).checkForNilOrEmpty
        twitterHandle = try values.decode(String?.self, forKey: .twitterHandle).checkForNilOrEmpty
        facebookHandle = try values.decode(String?.self, forKey: .facebookHandle).checkForNilOrEmpty
        instagramHandle = try values.decode(String?.self, forKey: .instagramHandle).checkForNilOrEmpty
    }
}

private extension Optional where Wrapped == String {
    
    var checkForNilOrEmpty: String? {
        guard let self = self else { return nil }
        if self.isEmpty { return nil }
        return self
    }
}

private extension String {
    
    var asUrl: URL? {
        return URL(string: self)
    }
}
