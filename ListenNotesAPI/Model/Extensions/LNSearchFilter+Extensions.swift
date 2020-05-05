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
        if sortBy == .mostRecent { return true }
        if searchInFields != [.everything] { return true }
        if minMinuteLength != nil { return true }
        if maxMinuteLength != nil { return true }
        if publishedAfter != nil { return true }
        if publishedBefore != nil { return true }
        if safeMode != .off { return true }
        if language != nil { return true }
        if !genreIds.isEmpty { return true }
        if podcastId != nil { return true }
        
        return false
    }
}
