//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

enum Palette: String {
    case background = "background"
    case darkLabel = "dark.text"
}

extension Palette {
    var color:UIColor {
        switch self {
        case .background:
            return UIColor(named: "background", in: .module, compatibleWith: .none)!
        case .darkLabel:
            return UIColor(named: "dark.text", in: .module, compatibleWith: .none)!
        }
    }
}
