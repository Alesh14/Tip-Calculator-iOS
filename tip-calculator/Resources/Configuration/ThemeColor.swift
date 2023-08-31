//
//  ThemeColor.swift
//  tip-calculator
//
//  Created by Alisher Manatbek on 20.08.2023.
//

import UIKit

enum ThemeColor: String {
    case background
    case primary
    case secondary
    case text
    case separator
    
    var color: UIColor {
        switch self {
        case.background:
            return UIColor(hexString: "F5F3F4")
        case.primary:
            return UIColor(hexString: "1CC9BE")
        case.secondary:
            return UIColor.systemOrange
        case.text:
            return UIColor(hexString: "000000")
        case.separator:
            return UIColor(hexString: "CCCCCC")
        }
    }
}
