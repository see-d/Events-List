//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

extension Feature.Domain.Sport.EventsController: OnChangeDelegate {
    func render(for state: Feature.State) {
        switch state {
        case .loading:
            // TODO: show loader
            print("loading...")
        case .loaded:
            tableview.reloadData()
        case .failure(let error):
            // TODO: show error
            print("on error: \(error?.localizedDescription)")
        default:
            return
        }
    }
}

