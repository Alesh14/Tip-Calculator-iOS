//
//  Tip.swift
//  tip-calculator
//
//  Created by Alisher Manatbek on 26.08.2023.
//

enum Tip {
    case none
    case tenPercent
    case fifteenPercent
    case twentyPercent
    case custom(value: Int)
    
    var stringValue: String {
        switch self {
        case .none:
            return "none"
        case .tenPercent:
            return "10%"
        case .fifteenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .custom(let value):
            return "\(value)"
        }
    }
}
