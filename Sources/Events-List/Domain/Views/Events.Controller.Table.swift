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
        tableview.delegate = self
        
        tableview.rowHeight = view.frame.height/6
        tableview.estimatedRowHeight = UITableView.automaticDimension
        
        tableview.sectionFooterHeight = .leastNormalMagnitude
        tableview.sectionHeaderHeight = UITableView.automaticDimension
        
        tableview.insetsContentViewsToSafeArea = true

        if #available(iOS 15.0, *) {
            tableview.sectionHeaderTopPadding = 0.0
        }
        
        tableview.separatorStyle = .none
        
        tableview.register(events.Cell.self,
                           forCellReuseIdentifier: events.Cell.reuseIdentifier)
        tableview.register(events.TitleHeader.self,
                           forHeaderFooterViewReuseIdentifier: events.TitleHeader.reuseIdentifier)
    }
}

extension Feature.Domain.Sport.EventsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewmodel.events.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.showEvents(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: events.Cell.reuseIdentifier,
                                                 for: indexPath)
        
        (cell as? events.Cell)?.prepare(with: viewmodel.events(for: indexPath.section))
        return cell
    }
}

extension Feature.Domain.Sport.EventsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: events.TitleHeader.reuseIdentifier)
        
        let toggleAction = { [weak self] in
            guard let self else { return }
            let on = self.viewmodel.toggleEvents(for: section)
            
            switch on {
            case false:
                self.tableview.insertRows(at: [IndexPath(row:0, section: section)], with: .automatic)
            case true:
                self.tableview.deleteRows(at: [IndexPath(row:0, section: section)], with: .automatic)
            }
        }
        
        (header as? events.TitleHeader)?.prepare(with: viewmodel.title(for: section),
                                                 toggle: toggleAction)
        return header
    }
}
