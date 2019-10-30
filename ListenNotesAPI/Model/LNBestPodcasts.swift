//
//  LNBestPodcasts.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/25/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

public struct LNBestPodcasts: Decodable {
    public let id: Int
    public let name: String
    public let total: Int
    public let hasNext: Bool
    public let podcasts: [LNPodcast]
    public let parentId: Int?
    public let pageNumber: Int
    public let hasPrevious: Bool
    public let listenNotesUrl: URL
    public let nextPageNumber: Int?
    public let previousPageNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case total
        case hasNext = "has_next"
        case podcasts
        case parentId = "parent_id"
        case pageNumber = "page_number"
        case hasPrevious = "has_previous"
        case listenNotesUrl = "listennotes_url"
        case nextPageNumber = "next_page_number"
        case previousPageNumber = "previous_page_number"
    }
}
