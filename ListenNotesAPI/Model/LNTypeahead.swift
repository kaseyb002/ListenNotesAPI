//
//  LNTypeahead.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

public struct LNTypeahead: Codable {
    public let terms: [String]
    public let genres: [LNGenre]?
    public let podcasts: [LNPodcast]?
}
