//
//  LNGenre.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

public struct LNGenre: Codable {
    public let id: Int
    public let name: String
    public let parentId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case parentId = "parent_id"
    }
}
