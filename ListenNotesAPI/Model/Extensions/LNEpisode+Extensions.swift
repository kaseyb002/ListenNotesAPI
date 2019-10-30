//
//  LNEpisode+Extensions.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

extension LNEpisode {
    
    public var pubDate: Date {
        return Date(timeIntervalSince1970: (Double(pubDateMs) / 1000.0))
    }
}
