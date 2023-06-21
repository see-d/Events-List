//
//  Sports.Repository.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation
import API_Service

class SportsRepository: NSObject, Repository {
    typealias Sport = Feature.API.Sport
    @objc dynamic var data:[Sport] = []
    @objc dynamic var error:Error?
    
    func fetch() {
        let api = Feature.API.Sports.fetch
        API_Service.make(request: api) { [weak self] (response:[Sport]?, error:Error?) in
            DispatchQueue.main.async {
                guard let self else { return }
                guard let response else {
                    self.error = error ?? NSError(domain: "fetch.repository.events", code: 400)
                    return
                }
                self.data = response
            }
        }
    }
}
