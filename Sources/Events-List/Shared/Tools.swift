//
//  Tools.swift
//  
//
//  Created by Corey Duncan on 21/6/23.
//

import UIKit

extension UIView {
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 16.0).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

extension Date {
    /// Formats time between a date and today.
    /// If the date has passed it will return 00:00:00
    ///
    /// - Important: Not localized!
    ///
    func countdown() -> String {
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: Date(), to: self)
        
        let month: String? =  {
            guard let value = components.month, value > 0 else { return nil }
            return "\(value) month"+(value > 1 ? "s" : "")
        }()
        let days: String? = {
            guard let value = components.day, value > 0 else { return nil }
            return "\(value) day"+(value > 1 ? "s" : "")
        }()
        let date = [month, days].compactMap{ $0 }.joined(separator: " ")
        
        let hours = {
            guard let value = components.hour, value > 0 else { return "00" }
            return "\(value)"
        }()
        let minutes = {
            guard let value = components.minute, value > 0 else { return "00" }
            return value > 9 ? "\(value)" : "0\(value)"
        }()
        let seconds = {
            guard let value = components.second, value > 0 else { return "00" }
            return value > 9 ? "\(value)" : "0\(value)"
        }()
        let time = [hours, minutes, seconds].joined(separator: ":")
        
        return [date,time].joined(separator: " ")
    }
}
