//
//  Sports.API.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import Foundation
import API_Service

extension Feature.API {
    enum Sports {
        case fetch
    }
}

extension Feature.API.Sports : API {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "618d3aa7fe09aa001744060a.mockapi.io"
    }
    
    var path: String {
        return "/api"
    }
    
    var endpoint: String {
        return "/sports"
    }
    
    var query: [URLQueryItem] {
        return []
    }
    
    var method: String {
        return "GET"
    }
}
