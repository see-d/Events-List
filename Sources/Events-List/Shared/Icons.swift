//
//  File.swift
//  
//
//  Created by Corey Duncan on 20/6/23.
//

import UIKit

enum Icon {
    case toggleOn, toggleOff
}

extension Icon {
    var image:UIImage {
        switch self {
        case .toggleOn:
            return UIImage(named: "toggle.down", in: .module, compatibleWith: .none)!
        case .toggleOff:
            return UIImage(named: "toggle.up", in: .module, compatibleWith: .none)!
        }
    }
}
