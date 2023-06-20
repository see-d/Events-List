//
//  Event.Cell.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

extension Feature.Domain.Sport.Event {
    class Cell: UICollectionViewCell {
        typealias Event = Feature.Domain.Sport.Event
        static let reuseIdentifier: String = String(describing: Event.Cell.self)
        
        private lazy var content:UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .center
            
            return stack
        }()
        
        private lazy var eventTime:UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            return label
        }()
        
        private lazy var timeFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            formatter.locale = .autoupdatingCurrent
            
            return formatter
        }()
        
        private lazy var eventDescription:UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.numberOfLines = 2
            return label
        }()
        
        private lazy var isFavorite:UIImageView = {
            let image = UIImageView(image:Icon.favoriteOff.image)
            image.tintColor = Palette.favorite.color
            image.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                image.heightAnchor.constraint(equalToConstant: 15),
                image.widthAnchor.constraint(equalTo: image.heightAnchor)
            ])
            
            return image
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)

            configureViewHierarchy()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func prepare(with event: Event){
            eventTime.text = timeFormatter.string(from: event.timeToEvent)
            eventDescription.text = event.title
        }
        
        private func configureViewHierarchy() {
            backgroundColor = .red //Palette.background.color
            self.contentView.backgroundColor = .red //Palette.background.color
            
            addSubview(content)
            content.addArrangedSubview(eventTime)
            content.addArrangedSubview(isFavorite)
            content.addArrangedSubview(eventDescription)
            
            content.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: content.leadingAnchor),
                trailingAnchor.constraint(equalTo: content.trailingAnchor),
                topAnchor.constraint(equalTo: content.topAnchor),
                bottomAnchor.constraint(equalTo: content.bottomAnchor),
            ])
        }
    }
}

