//
//  Sports.Repository.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation
import API_Service

struct SportsRepository: Repository {
    typealias Sport = Feature.API.Sport

    func fetch(_ completion:@escaping ([Sport]?, Error?) -> Void) {
        let api = Feature.API.Sports.fetch
        API_Service.make(request: api, completion: completion)
    }
}
