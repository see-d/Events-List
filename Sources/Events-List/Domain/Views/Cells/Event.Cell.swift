//
//  Event.Cell.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

extension Feature.Domain.Sport.Event {
    class Cell: UICollectionViewCell {
        typealias event = Feature.Domain.Sport.Event
        static let reuseIdentifier: String = String(describing: event.Cell.self)
        
        override init(frame: CGRect) {
            super.init(frame: frame)

            self.contentView.backgroundColor = .red
            
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

