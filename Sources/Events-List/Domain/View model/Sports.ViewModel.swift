//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation

extension Feature.Domain.Sport {
    class ViewModel {
        typealias event = Feature.Domain.Sport
        private let repository: EventsRepository
        
        private lazy var dataObserver:NSKeyValueObservation = {
            return repository.observe(\.data) { [weak self] object, change in
                self?.events = object.data.compactMap{ event(with: $0) }
            }
        }()
        
        private lazy var errorObserver:NSKeyValueObservation = {
            return repository.observe(\.error) { object, change in
                // TODO: post for error display
                print("did receive error: \(object.error?.localizedDescription ?? "empty")")
            }
        }()
        
        private(set) var events:[event] = []
        
        init(repository: EventsRepository) {
            self.repository = repository
            
            repository.fetch()
        }
        
        func showEvents(in section:Int) -> Int {
            // each section conprises no more than 1 cell.
            // to display this cell is dependent on whether the section has been "toggled" on/off
            // TODO: implement on/off
            return 1 // 0 || 1
        }
        
        func title(for section:Int) -> String? {
            guard events.indices.contains(section) else { return nil }
            return events[section].title
        }
    }
}
