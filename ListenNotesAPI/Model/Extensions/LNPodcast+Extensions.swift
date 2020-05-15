//
//  LNPodcast+Extensions.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

extension LNPodcast {
    
    public var latestPubDate: Date {
        Date(timeIntervalSince1970: (Double(latestPubDateMs) / 1000.0))
    }
    
    public var earliestPubDate: Date {
        Date(timeIntervalSince1970: (Double(earliestPubDateMs) / 1000.0))
    }
}
