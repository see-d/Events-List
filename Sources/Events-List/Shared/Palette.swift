//
//  Palette.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

enum Palette: String {
    case background = "background"
    case darkText = "dark.text"
    case favorite = "favorite"
}

extension Palette {
    var color:UIColor {
        switch self {
        case .background:
            return UIColor(named: "background", in: .module, compatibleWith: .none)!
        case .darkText:
            return UIColor(named: "dark.text", in: .module, compatibleWith: .none)!
        case .favorite:
            return UIColor(named: "favorite", in: .module, compatibleWith: .none)!
        }
    }
}
