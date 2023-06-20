//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation

extension Feature.Domain.Sport {
    struct Event {
        let id: String
        let sport: String
        let title: String
        let time: Date
        
        init(id: String, sport: String, title: String, time: Date) {
            self.id = id
            self.sport = sport
            self.title = title
            self.time = time
        }
        
        init(with response: Feature.API.Sport.Event) {
            id = response.id
            sport = response.sport
            title = response.title
            time = Date(timeIntervalSince1970: TimeInterval(response.time))
        }
    }
}
