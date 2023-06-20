//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation

extension Feature.API.Sport {
    struct Event: Decodable {
        let id: String
        let sport: String
        let title: String
        let time: Int
        
        enum CodingKeys: String, CodingKey, CaseIterable {
            case id = "i"
            case sport = "si"
            case title = "d"
            case time = "tt"
        }
    }
}
