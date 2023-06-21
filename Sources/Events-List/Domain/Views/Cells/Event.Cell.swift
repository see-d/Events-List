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
            stack.spacing = 8.0
            
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
            formatter.dateStyle = .short
            formatter.timeStyle = .short
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
            label.font = UIFont.systemFont(ofSize: 24)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
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
            
            toggleFavorite.isSelected = false
        }
        
        func prepare(with event: Event, isFavourite:Bool, toggle:@escaping (Bool) -> ()?){
            eventTime.text = event.timeToEvent.countdown()
            eventDescription.text = event.title
            toggleAction = toggle
            
            toggleFavorite.isSelected = isFavourite
            toggleFavorite.addTarget(self, action: #selector(toggleFavorite(_:)), for: .touchUpInside)
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
        
        @objc private func toggleFavorite(_ sender:UIButton) {
            sender.isSelected.toggle()
            toggleAction?(sender.isSelected)
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

extension Date {
    /// Calculates time between a date and today.
    /// If the date has passed it will return 00:00:00
    ///
    /// - Important: Not localized!
    ///
    func countdown() -> String {
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: Date(), to: self)
        
        let month: String? =  {
            guard let value = components.month, value > 0 else { return nil }
            return "\(value) month"+(value > 1 ? "s" : "")
        }()
        let days: String? = {
            guard let value = components.day, value > 0 else { return nil }
            return "\(value) day"+(value > 1 ? "s" : "")
        }()
        let date = [month, days].compactMap{ $0 }.joined(separator: " ")
        
        let hours = {
            guard let value = components.hour, value > 0 else { return "00" }
            return "\(value)"
        }()
        let minutes = {
            guard let value = components.minute, value > 0 else { return "00" }
            return value > 9 ? "\(value)" : "0\(value)"
        }()
        let seconds = {
            guard let value = components.second, value > 0 else { return "00" }
            return value > 9 ? "\(value)" : "0\(value)"
        }()
        let time = [hours, minutes, seconds].joined(separator: ":")
        
        return [date,time].joined(separator: " ")
    }
}

