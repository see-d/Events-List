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
        private let time: Date
        
        var timeToEvent: Date {
            return Date(timeInterval: time.timeIntervalSince1970, since: Date())
        }
        
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
