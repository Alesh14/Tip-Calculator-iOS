//
//  LabelFactory.swift
//  tip-calculator
//
//  Created by Alisher Manatbek on 22.08.2023.
//

import UIKit

struct LabelFactory {
    
    static func build(text: String?, font: UIFont, backgroundColor: UIColor = .clear, textColor: UIColor = ThemeColor.text.color, textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
    
}
