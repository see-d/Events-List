//
//  Events.Controller.Table.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

extension Feature.Domain.Sport.EventsController {
    func configureTableView() {
        tableview.dataSource = self
        
        tableview.rowHeight = view.frame.height/6
        tableview.estimatedRowHeight = UITableView.automaticDimension
        
        tableview.estimatedSectionHeaderHeight = UITableView.automaticDimension
        
        tableview.register(Feature.Domain.Sport.Cell.self,
                           forCellReuseIdentifier: Feature.Domain.Sport.Cell.reuseIdentifier)
    }
}

extension Feature.Domain.Sport.EventsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0 // TODO: get from viewmodel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 // TODO: get from viewmodel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Feature.Domain.Sport.Cell.reuseIdentifier,
                                                 for: indexPath)
        
        return cell
    }
}

extension Feature.Domain.Sport.EventsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil // TODO: get from viewmodel
    }
}
