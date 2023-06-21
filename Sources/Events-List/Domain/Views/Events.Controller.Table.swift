//
//  Events.Controller.Table.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

extension Feature.Domain.Sport.EventsController {
    private var cellHeight: Double {
        return view.frame.height*0.35
    }
    
    func configureTableView() {
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.rowHeight = cellHeight
        tableview.estimatedRowHeight = UITableViewAutomaticDimension
        
        tableview.sectionFooterHeight = .leastNormalMagnitude
        tableview.sectionHeaderHeight = UITableViewAutomaticDimension
        
        tableview.insetsContentViewsToSafeArea = true

        if #available(iOS 15.0, *) {
            tableview.sectionHeaderTopPadding = 0.0
        }
        
        tableview.separatorStyle = .none
        
        tableview.register(Sport.Cell.self,
                           forCellReuseIdentifier: Sport.Cell.reuseIdentifier)
        tableview.register(Sport.TitleHeader.self,
                           forHeaderFooterViewReuseIdentifier: Sport.TitleHeader.reuseIdentifier)
    }
}

extension Feature.Domain.Sport.EventsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewmodel.sports.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.showEvents(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Sport.Cell.reuseIdentifier,
                                                 for: indexPath)
        
        (cell as? Sport.Cell)?.prepare(with: viewmodel.events(for: indexPath.section),
                                        favourites:viewmodel.favourites)
        (cell as? Sport.Cell)?.favouritesDelegate = viewmodel
        return cell
    }
}

extension Feature.Domain.Sport.EventsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Sport.TitleHeader.reuseIdentifier)
        
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
        
        (header as? Sport.TitleHeader)?.prepare(with: viewmodel.title(for: section),
                                                 toggle: toggleAction)
        return header
    }
}
