//
//  Sport.Cell.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

protocol EventFavouritesDelegate: AnyObject {
    func updateEvent(favourite:Bool, id: String)
}

extension Feature.Domain.Sport {
    class Cell: UITableViewCell {
        typealias sport = Feature.Domain.Sport
        static let reuseIdentifier: String = String(describing: sport.Cell.self)
        
        weak var favouritesDelegate:EventFavouritesDelegate?
        
        private var events:[sport.Event] = []
        private var favourites:[String] = []
        
        lazy var collection = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            let collection = UICollectionView(frame: contentView.frame,
                                              collectionViewLayout: layout)
            return collection
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            backgroundColor = Palette.background.color
            contentView.backgroundColor = Palette.background.color
            
            clipsToBounds = false
            
            addSubview(collection)
            configureCollection()
            
            collection.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: collection.leadingAnchor),
                trailingAnchor.constraint(equalTo: collection.trailingAnchor),
                bottomAnchor.constraint(equalTo: collection.bottomAnchor),
                topAnchor.constraint(equalTo: collection.topAnchor),
            ])
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            
            self.events = []
            collection.reloadData()
        }
        
        func prepare(with events:[sport.Event], favourites: [String]) {
            let sorted = events.sorted(by: {
                return $0.timeToEvent > $1.timeToEvent //|| favourites.contains( $1.id )
            })
            self.events = sorted
            self.favourites = favourites
        }
    }
}

extension Feature.Domain.Sport.Cell {
    private func configureCollection() {
        
        collection.insetsLayoutMarginsFromSafeArea = true
        collection.contentInsetAdjustmentBehavior = .automatic
        
        collection.contentInset.left = 16.0
        collection.contentInset.right = 16.0
        
        collection.keyboardDismissMode = .onDrag
        collection.showsVerticalScrollIndicator = false
        
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        
        collection.register(sport.Event.Cell.self,
                            forCellWithReuseIdentifier: sport.Event.Cell.reuseIdentifier)
        
        collection.dataSource = self
        collection.delegate = self
        
        collection.clipsToBounds = false
    }
}


extension Feature.Domain.Sport.Cell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sport.Event.Cell.reuseIdentifier,
                                                      for: indexPath)
        
        if events.indices.contains(indexPath.row) {
            let event = events[indexPath.row]
            
            let toggleAction = { [weak self] (favorite:Bool) in
                guard let self else { return }
                self.favouritesDelegate?.updateEvent(favourite: favorite, id: event.id)
            }
            
            let isFavorite = favourites.contains(event.id)
            (cell as? sport.Event.Cell)?.prepare(with: event,
                                                 isFavourite: isFavorite,
                                                 toggle: toggleAction)
        }
        // TODO: add fallback empty/error state
        
        return cell
    }
}

extension Feature.Domain.Sport.Cell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 1.2
        let horizontalPadding = 8.0
        let verticalPadding = 16.0
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - horizontalPadding
        let itemHeight = collectionView.bounds.height - (2 * verticalPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}


