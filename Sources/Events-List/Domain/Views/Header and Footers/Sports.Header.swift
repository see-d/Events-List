//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

extension Feature.Domain.Sport {
    class TitleHeader: UITableViewHeaderFooterView {
        typealias sport = Feature.Domain.Sport
        static var reuseIdentifier: String = String(describing: sport.TitleHeader.self)
        
        private lazy var content = {
            let stack = UIStackView()
            stack.distribution = .fill
            stack.alignment = .center
            stack.axis = .horizontal
            
            return stack
        }()
        
        private lazy var titleLabel = {
            let label = UILabel()
            label.textColor = Palette.darkLabel.color
            return label
        }()
        
        private lazy var toggleButton = {
            let button = UIButton(type: .custom)
            button.contentVerticalAlignment = .fill
            button.contentHorizontalAlignment = .fill
            button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            
            button.setContentHuggingPriority(.required, for: .horizontal)
            
            button.tintColor = Palette.darkLabel.color
            
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
            backgroundColor = Palette.background.color
            contentView.backgroundColor = Palette.background.color
            
            content.addArrangedSubview(titleLabel)
            content.addArrangedSubview(toggleButton)
            
            addSubview(content)
            
            content.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: content.leadingAnchor),
                trailingAnchor.constraint(equalTo: content.trailingAnchor),
                topAnchor.constraint(equalTo: content.topAnchor),
                bottomAnchor.constraint(equalTo: content.bottomAnchor)
            ])
        }
        
        @objc private func buttonToggle() {
            toggleButton.isSelected.toggle()
            toggleAction?()
        }
    }
}

