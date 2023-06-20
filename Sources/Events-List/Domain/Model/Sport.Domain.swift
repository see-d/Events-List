//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation

extension Feature.Domain {
    struct Sport {
        let id: String
        let title: String
        let events: [Event]
        
        init(id: String, title: String, events: [Event]) {
            self.id = id
            self.title = title
            self.events = events
        }
        
        init(with response:Feature.API.Sport) {
            id = response.id
            title = response.title
            events = response.events.compactMap{ Feature.Domain.Sport.Event(with: $0) }
        }
    }
}
