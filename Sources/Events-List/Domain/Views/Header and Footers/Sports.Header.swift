//
//  Sports.Header.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

extension Feature.Domain.Sport {
    class TitleHeader: UITableViewHeaderFooterView {
        typealias Sport = Feature.Domain.Sport
        static var reuseIdentifier: String = String(describing: Sport.TitleHeader.self)
        
        private lazy var content = {
            let stack = UIStackView()
            stack.distribution = .fill
            stack.alignment = .center
            stack.axis = .horizontal
            
            return stack
        }()
        
        private lazy var titleLabel = {
            let label = UILabel()
            label.textColor = Palette.darkText.color
            
            label.adjustsFontForContentSizeCategory = true
            label.font = UIFont.preferredFont(forTextStyle: .subheadline)
            
            return label
        }()
        
        private lazy var toggleButton = {
            let button = UIButton(type: .custom)
            button.accessibilityHint = "show or hide events for this sport"
            
            button.contentVerticalAlignment = .fill
            button.contentHorizontalAlignment = .fill
            button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            
            button.setContentHuggingPriority(.required, for: .horizontal)
            
            button.tintColor = Palette.darkText.color
            
            button.setImage(Icon.toggleOn.image, for: .selected)
            button.setImage(Icon.toggleOff.image, for: .normal)
            
            return button
        }()
        
        private var toggleAction: (() -> ()?)?

        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            
            configureViewHierarchy()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func prepare(with title:String?, toggle:@escaping () -> ()?) {
            titleLabel.text = title
            toggleAction = toggle
            
            toggleButton.addTarget(self, action: #selector(buttonToggle), for: .touchUpInside)
        }
        
        private func configureViewHierarchy() {
            contentView.backgroundColor = Palette.background.color
            
            content.addArrangedSubview(titleLabel)
            content.addArrangedSubview(toggleButton)
            
            contentView.addSubview(content)
            
            content.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                contentView.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: -8.0),
                contentView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
                contentView.topAnchor.constraint(equalTo: content.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: content.bottomAnchor)
            ])
        }
        
        @objc private func buttonToggle() {
            toggleButton.isSelected.toggle()
            toggleAction?()
        }
    }
}

