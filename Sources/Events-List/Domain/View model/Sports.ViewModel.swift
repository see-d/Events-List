//
//  Sports.ViewModel.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation

extension Feature.Domain.Sport {
    class ViewModel {
        typealias Sport = Feature.Domain.Sport
        weak var onChangeDelegate: OnChangeDelegate?
        
        private let repository: SportsRepository
        
        private(set) var favourites:[String] = []
        private var visibleSections:[Int] = []
        private(set) var sports:[Sport] = [] {
            didSet {
                onChangeDelegate?.render(for: .loaded)
            }
        }
        
        init(repository: SportsRepository) {
            self.repository = repository
            
            onChangeDelegate?.render(for: .loading)
            load()
        }
        
        /// Each section conprises no more than 1 cell.
        /// whether to display this cell is dependent on whether the section has been "toggled" on/off
        ///
        func showEvents(in section:Int) -> Int {
            return visibleSections.contains(section) ? 0 : 1
        }
        
        func title(for section:Int) -> String? {
            guard sports.indices.contains(section) else { return nil }
            return sports[section].title
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
        
        func events(for section: Int) -> [Sport.Event] {
            guard sports.indices.contains(section) else { return [] }
            return sports[section].events
        }
        
        private func load() {
            repository.fetch { [weak self] data, error in
                guard let self else { return }
                guard let error else {
                    let sports = data?.compactMap{ Sport(with: $0) } ?? []
                    self.sortAndDisplay(sports)
                    return
                }
                self.onChangeDelegate?.render(for: .failure(error))
            }
        }
        
        private func sortAndDisplay(_ sports:[Sport]) {
            let ordered = sports.compactMap { sport in
                let sorted = sport.events.sorted(by: {
                    return $0.time < $1.time
                })
                
                let favorites = sorted.filter{ favourites.contains($0.id) }
                let others = sorted.filter{ !favourites.contains($0.id) }
                
                let allEvents = favorites+others
                
                return Sport(id: sport.id, title: sport.title, events: allEvents)
            }

            self.sports = ordered
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
        sortAndDisplay(sports)
    }
}
