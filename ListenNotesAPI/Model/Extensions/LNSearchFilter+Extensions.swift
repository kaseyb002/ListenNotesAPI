//
//  LNSearchFilter+Extensions.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 5/4/20.
//  Copyright © 2020 Kasey Baughan. All rights reserved.
//

import Foundation

public extension LNSearchFilter {
    
    /// Whether the default settings have been changed
    var isOn: Bool {
        if
            sortBy == .relevance,
            searchInFields == [.everything],
            minMinuteLength == nil,
            maxMinuteLength == nil,
            publishedAfter == nil,
            publishedBefore == nil,
            safeMode == .off,
            language == nil,
            genreIds.isEmpty,
            podcastId == nil
            { return false }
        
        return true
    }
}
