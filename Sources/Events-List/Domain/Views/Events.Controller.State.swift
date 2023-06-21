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
                // TODO: show loader
                print("loading...")
            case .loaded:
                self?.tableview.reloadData()
            case .failure(let error):
                // TODO: show error
                print("on error: \(error?.localizedDescription ?? "")")
            default:
                return
            }
        }
    }
}

