//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

class EventsController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let test = UILabel()
        test.text = "testing"
        
        view.addSubview(test)
        
        test.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            test.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            test.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
