//
//  LNSearchFilter+Extensions.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 5/4/20.
//  Copyright © 2020 Kasey Baughan. All rights reserved.
//

import Foundation

public extension LNSearchFilter {
    
    var isOn: Bool {
        guard let data = try? JSONEncoder().encode(self) else { return false }
        return !data.isEmpty
    }
}
