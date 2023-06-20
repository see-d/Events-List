//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

enum Icon {
    case toggleOn, toggleOff
    case favoriteOn, favoriteOff
}

extension Icon {
    var image:UIImage {
        switch self {
        case .toggleOn:
            return UIImage(named: "toggle.down", in: .module, compatibleWith: .none)!
        case .toggleOff:
            return UIImage(named: "toggle.up", in: .module, compatibleWith: .none)!
        case .favoriteOn:
            return UIImage(named: "favorite.on", in: .module, compatibleWith: .none)!
        case .favoriteOff:
            return UIImage(named: "favorite.off", in: .module, compatibleWith: .none)!
        }
    }
}
