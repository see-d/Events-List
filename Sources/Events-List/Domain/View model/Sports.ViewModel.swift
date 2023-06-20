//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation

protocol OnChangeDelegate: AnyObject {
    func render(for state:Feature.State)
}

extension Feature.Domain.Sport {
    class ViewModel {
        typealias event = Feature.Domain.Sport
        weak var onChangeDelegate: OnChangeDelegate?
        
        private let repository: EventsRepository
        
        private lazy var dataObserver:NSKeyValueObservation = {
            return repository.observe(\.data) { [weak self] object, change in
                self?.sortAndDisplay(events: object.data)
            }
        }()
        
        private lazy var errorObserver:NSKeyValueObservation = {
            return repository.observe(\.error) { [weak self] object, change in
                self?.onChangeDelegate?.render(for: .failure(object.error))
            }
        }()
        
        private(set) var favourites:[String] = []
        private var visibleSections:[Int] = []
        private(set) var events:[event] = [] {
            didSet {
                onChangeDelegate?.render(for: .loaded)
            }
        }
        
        init(repository: EventsRepository) {
            self.repository = repository
            
            onChangeDelegate?.render(for: .loading)
            
            _ = dataObserver
            _ = errorObserver
            
            repository.fetch()
        }
        
        func showEvents(in section:Int) -> Int {
            // each section conprises no more than 1 cell.
            // whether to display this cell is dependent on whether the section has been "toggled" on/off
            //
            return visibleSections.contains(section) ? 0 : 1
        }
        
        func title(for section:Int) -> String? {
            guard events.indices.contains(section) else { return nil }
            return events[section].title
        }
        
        func toggleEvents(for section: Int) -> Bool {
            if visibleSections.contains(section) {
                visibleSections.removeAll(where: { $0 == section} )
                return false
            } else {
                visibleSections.append(section)
                return true
            }
        }
        
        func events(for section: Int) -> [event.Event] {
            guard events.indices.contains(section) else { return [] }
            return events[section].events
        }
        
        private func sortAndDisplay(events:[Feature.API.Sport]) {
            let sorted = events.compactMap{
                let events = $0.events.sorted(by: {
                    return $0.time < $1.time
                }).compactMap{ event.Event(with: $0) }
                
                return event(id: $0.id, title: $0.title, events: events)
            }
            self.events = sorted
        }
    }
}

extension Feature.Domain.Sport.ViewModel: EventFavouritesDelegate {
    func updateEvent(favourite: Bool, id: String) {
        if favourites.contains(id) {
            favourites.removeAll(where: { $0 == id })
        } else {
            favourites.append(id)
        }
        onChangeDelegate?.render(for: .loaded)
    }
}
