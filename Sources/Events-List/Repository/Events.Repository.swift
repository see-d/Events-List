//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation
import API_Service

class EventsRepository: Repository {
    var data:[Feature.API.Sport] = []
    
    func fetch() {
        let api = Feature.API.Sports.fetch
        API_Service.make(request: api) { [weak self] (response:[Feature.API.Sport]?, error:Error?) in
            DispatchQueue.main.async {
                guard let self else { return }
                guard let response else {
                    let error = error ?? NSError(domain: "fetch.repository.events", code: 400)
                    return
                }
                self.data = response
            }
        }
    }
}
