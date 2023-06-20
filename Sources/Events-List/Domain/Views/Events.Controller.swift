//
//  Events.Controller.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

extension Feature.Domain.Sport {
    class EventsController : UIViewController {
        typealias events = Feature.Domain.Sport
        private(set) var viewmodel: events.ViewModel
        lazy var tableview = UITableView(frame: view.frame, style: .plain)
        
        required init(with viewmodel: events.ViewModel) {
            self.viewmodel = viewmodel
            
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            prepareViewHeirarchy()
        }
        
        private func prepareViewHeirarchy() {
            view.backgroundColor = .white
            displayTableview()
        }

        private func displayTableview() {
            configureTableView()
            view.addSubview(tableview)
            tableview.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: tableview.topAnchor),
                view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableview.bottomAnchor),
                view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: tableview.leadingAnchor),
                view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: tableview.trailingAnchor)
            ])
        }
    }
}

