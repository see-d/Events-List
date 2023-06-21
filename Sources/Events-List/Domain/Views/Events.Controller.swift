//
//  Events.Controller.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

extension Feature.Domain.Sport {
    class EventsController : UIViewController {
        typealias Sport = Feature.Domain.Sport
        private(set) var viewmodel: Sport.ViewModel
        lazy var tableview = {
            let tableview = UITableView(frame: view.frame, style: .plain)
            
            view.addSubview(tableview)
            tableview.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: tableview.topAnchor),
                view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableview.bottomAnchor),
                view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: tableview.leadingAnchor),
                view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: tableview.trailingAnchor)
            ])
            
            return tableview
        }()
        
        lazy var activityIndicator = {
            let activity = UIActivityIndicatorView(style: .whiteLarge)
            activity.hidesWhenStopped = true
            activity.color = .black
            
            view.insertSubview(activity, aboveSubview: tableview)
            activity.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                activity.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                activity.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
            ])
            
            return activity
        }()
        
        required init(with viewmodel: Sport.ViewModel) {
            self.viewmodel = viewmodel
            
            super.init(nibName: nil, bundle: nil)
            
            activityIndicator.startAnimating()
            viewmodel.onChangeDelegate = self
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            NotificationCenter.default.addObserver(self, selector: #selector(didMoveFromBackground), name: UIApplication.didBecomeActiveNotification, object: nil)
            prepareViewHeirarchy()
        }

        @objc private func didMoveFromBackground(_ notification: Notification) {
           
            tableview.reloadData()
        }
        
        private func prepareViewHeirarchy() {
            view.backgroundColor = Palette.background.color
            displayTableview()
        }

        private func displayTableview() {
            configureTableView()
        }
    }
}

