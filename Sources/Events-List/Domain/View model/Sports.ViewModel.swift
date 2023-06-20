//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation

extension Feature.Domain.Sport {
    struct ViewModel {
        private let repository: EventsRepository
        private let dataObserver:NSKeyValueObservation
        private let errorObserver:NSKeyValueObservation
        
        init(repository: EventsRepository) {
            self.repository = repository
            
            dataObserver = repository.observe(\.data) { object, change in
                // TODO: post for table reload
                print("did fetch: \(object.data)")
            }
            
            errorObserver = repository.observe(\.error) { object, change in
                // TODO: post for error display
                print("did receive error: \(object.error?.localizedDescription ?? "empty")")
            }
            
            repository.fetch()
        }
    }
}
