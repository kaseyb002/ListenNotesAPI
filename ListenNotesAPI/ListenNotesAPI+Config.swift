//
//  ListenNotesAPI+Config.swift
//  ListenNotesAPI
//
//  Created by Kasey Baughan on 10/22/19.
//  Copyright © 2019 Kasey Baughan. All rights reserved.
//

import Foundation

extension ListenNotesAPI {
    
    public final class Config {
        private (set) static var apiKey: String?
        
        public static func set(apiKey: String) {
            self.apiKey = apiKey
        }
    }
}
