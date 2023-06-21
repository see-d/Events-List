//
//  Feature.Namespace.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation

struct Feature {
    struct API {}
    struct Domain {}
}

extension Feature {
    enum State {
        case initial, loading, loaded, failure(Error)
    }
}
