//
//  LNBestPodcasts.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/25/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

public struct LNBestPodcasts: Decodable {
    let id: Int
    let name: String
    let total: Int
    let hasNext: Bool
    let podcasts: [LNPodcast]
    let parentId: Int?
    let pageNumber: Int
    let hasPrevious: Bool
    let listenNotesUrl: URL
    let nextPageNumber: Int?
    let previousPageNumber: Int?
    
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
