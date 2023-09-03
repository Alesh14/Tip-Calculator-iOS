//
//  Extensions.swift
//  tip-calculator
//
//  Created by Alisher Manatbek on 20.08.2023.
//

import UIKit

// MARK: - UIColor

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}

// MARK: - UIView

extension UIView {
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let bgCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = bgCGColor
    }
    
    func addCornerRadius(radius: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    
    func addRoundedCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }
    
}

// MARK: - String

extension String {
    
    var doubleValue: Double? {
        Double(self)
    }
    
}

// MARK: - UIResponder

extension UIResponder {
    
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
    
}

// MARK: - Int

extension Int {
    
    var stringValue: String {
        return  "\(self)"
    }
    
}

// MARK: - Double

extension Double {
    
    var stringValue: String {
        return "\(self)"
    }
    
    var currencyFormatted: String {
        var isWholeNumber: Bool {
            return isZero == true ? true : (isNormal == false ? false : self == rounded())
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber == true ? 0 : 2
        return formatter.string(for: self) ?? "0"
    }
    
}
