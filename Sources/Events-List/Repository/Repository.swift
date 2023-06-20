//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation

protocol Repository {
    associatedtype T: Decodable
    var data:T { get set }
    func fetch()
}
