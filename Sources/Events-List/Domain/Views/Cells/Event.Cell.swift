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
        
        private lazy var content = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .fill
            
            return stack
        }()
        
        private lazy var eventTimeLabel = {
            let label = UILabel()
            label.text = "starts in:"
            label.textAlignment = .right
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            return label
        }()
        
        private lazy var eventTime = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            label.setContentHuggingPriority(.required, for: .horizontal)
            label.setContentHuggingPriority(.required, for: .vertical)
            return label
        }()
        
        private lazy var timeFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            formatter.locale = .autoupdatingCurrent
            
            return formatter
        }()
        
        private lazy var timeDisplayStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .bottom
            stack.spacing = 8.0
            
            stack.addArrangedSubview(eventTimeLabel)
            stack.addArrangedSubview(eventTime)

            eventTime.translatesAutoresizingMaskIntoConstraints = false
            eventTime.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
            
            return stack
        }()
        
        private lazy var eventDescription = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()
        
        private lazy var isFavorite = {
            let container = UIStackView()
            container.axis = .vertical
            container.alignment = .leading
            container.distribution = .fill
            
            let image = UIImageView(image:Icon.favoriteOff.image)
            image.tintColor = Palette.favorite.color
            image.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                image.heightAnchor.constraint(equalToConstant: 24),
                image.widthAnchor.constraint(equalTo: image.heightAnchor)
            ])
            
            container.addArrangedSubview(image)
            return container
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
            backgroundColor = Palette.background.color
            self.contentView.backgroundColor = Palette.background.color
        
            contentView.layer.cornerRadius = 16.0
            contentView.dropShadow()
            
            addSubview(content)
            content.addArrangedSubview(isFavorite)
            content.addArrangedSubview(eventDescription)
            content.addArrangedSubview(timeDisplayStack)
            
            content.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: -16),
                trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: 16),
                topAnchor.constraint(equalTo: content.topAnchor, constant: -16),
                bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: 16),
            ])
        }
    }
}

extension UIView {
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 16.0).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

