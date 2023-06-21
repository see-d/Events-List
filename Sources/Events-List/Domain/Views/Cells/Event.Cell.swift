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
            stack.distribution = .equalSpacing
            stack.alignment = .fill
            
            stack.addArrangedSubview(isFavorite)
            stack.addArrangedSubview(eventDescription)
            stack.addArrangedSubview(timeDisplayStack)
            
            eventDescription.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                eventDescription.centerYAnchor.constraint(equalTo: stack.centerYAnchor)
            ])
            
            return stack
        }()
        
        private lazy var eventTimeLabel = {
            let label = UILabel()
            
            label.text = "starts in:"
            label.textAlignment = .right
            
            label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
            
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
            
            label.adjustsFontForContentSizeCategory = true
            label.font = UIFont.preferredFont(forTextStyle: .caption2)
            
            return label
        }()
        
        private lazy var eventTime = {
            let label = UILabel()
            
            label.textAlignment = .right
            
            label.setContentHuggingPriority(.required, for: .horizontal)
            label.setContentHuggingPriority(.required, for: .vertical)
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
            
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
            
            label.adjustsFontForContentSizeCategory = true
            label.font = UIFont.preferredFont(forTextStyle: .subheadline)
            
            return label
        }()
        
        private lazy var timeDisplayStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .firstBaseline
            
            stack.addArrangedSubview(eventTimeLabel)
            stack.addArrangedSubview(eventTime)

            return stack
        }()
        
        private lazy var eventDescription = {
            let label = UILabel()
        
            label.textAlignment = .center
            label.numberOfLines = 0
            
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
            
            label.adjustsFontForContentSizeCategory = true
            label.font = UIFont.preferredFont(forTextStyle: .title2)
            
            return label
        }()
        
        private lazy var isFavorite = {
            let container = UIStackView()
            container.axis = .vertical
            container.alignment = .leading
            container.distribution = .fill
            
            container.addArrangedSubview(toggleFavorite)
            
            return container
        }()
        
        private lazy var toggleFavorite = {
            let button = UIButton(type: .custom)
            button.setImage(Icon.favoriteOff.image, for: .normal)
            button.setImage(Icon.favoriteOn.image, for: .selected)
            button.tintColor = Palette.favorite.color
            
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 44),
                button.widthAnchor.constraint(equalTo: button.heightAnchor)
            ])
            
            return button
        }()
        
        private var toggleAction: ((Bool) -> ()?)?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            configureViewHierarchy()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            
            configureViewAppearance()
        }
        
        func prepare(with event: Event, isFavourite:Bool, toggle:@escaping (Bool) -> ()?){
            eventTime.text = event.time.countdown()
            eventDescription.text = event.title
            toggleAction = toggle
            
            toggleFavorite.isSelected = isFavourite
            toggleFavorite.addTarget(self, action: #selector(toggleFavorite(_:)), for: .touchUpInside)
        }
        
        private func configureViewHierarchy() {
            contentView.addSubview(content)
            
            content.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: -16),
                trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: 16),
                topAnchor.constraint(equalTo: content.topAnchor, constant: -16),
                bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: 16),
            ])
            
            configureViewAppearance()
        }
        
        private func configureViewAppearance() {
            backgroundColor = nil
            self.contentView.backgroundColor = Palette.secondaryBackground.color
        
            contentView.layer.cornerRadius = 16.0
            
            switch traitCollection.userInterfaceStyle {
            case .dark:
                contentView.clipsToBounds = true
            default:
                contentView.clipsToBounds = false
                contentView.dropShadow()
            }
            
            toggleFavorite.isSelected = false
        }
        
        @objc private func toggleFavorite(_ sender:UIButton) {
            sender.isSelected.toggle()
            toggleAction?(sender.isSelected)
        }
    }
}
