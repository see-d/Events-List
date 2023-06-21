//
//  Events.Controller.State.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

protocol OnChangeDelegate: UIViewController {
    func render(for state:Feature.State)
}

extension Feature.Domain.Sport.EventsController: OnChangeDelegate {
    func render(for state: Feature.State) {
        DispatchQueue.main.async { [weak self] in
            switch state {
            case .loading:
                self?.toggleLoader(on: true)
            case .loaded:
                self?.toggleLoader(on: false)
                self?.tableview.reloadData()
            case .failure(let error):
                self?.show(error: error)
            default:
                return
            }
        }
    }
    
    private func show(error: Error) {
        toggleLoader(on: false)
        let alertController = UIAlertController(title: "Failed to load events",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "ok", style: .cancel)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
    
    private func toggleLoader(on: Bool) {
        switch on {
        case true:
            activityIndicator.startAnimating()
        default:
            activityIndicator.stopAnimating()
        }
    }
}

