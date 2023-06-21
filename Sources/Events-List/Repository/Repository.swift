//
//  Repository.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation

protocol Repository {
    associatedtype T: Decodable
    func fetch(_ completion:@escaping (T?,Error?)->Void)
}
