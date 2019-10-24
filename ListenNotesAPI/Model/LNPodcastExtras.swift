//
//  LNPodcastExtras.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

public struct LNPodcastExtras: Codable {
    let url1: URL?
    let url2: URL?
    let url3: URL?
    let googleUrl: URL?
    let spotifyUrl: URL?
    let youtubeUrl: URL?
    let linkedInUrl: URL?
    let weChatUrl: URL?
    let patreonHandle: String?
    let twitterHandle: String?
    let facebookHandle: String?
    let instagramHandle: String?
    
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
