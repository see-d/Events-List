//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation

extension Feature.API {
    struct Sport: Decodable {
        let id: String
        let title:String
        let events:[Event]
        
        enum CodingKeys: String, CodingKey, CaseIterable {
            case id = "i"
            case title = "d"
            case events = "e"
        }
    }
}
