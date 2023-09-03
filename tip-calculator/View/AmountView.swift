//
//  AmountView.swift
//  tip-calculator
//
//  Created by Alisher Manatbek on 24.08.2023.
//

import UIKit

class AmountView: UIView {
    
    private let title: String
    private let textAlignment: NSTextAlignment
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(text: title, font: ThemeFont.regular(ofSize: 18.0), textColor: ThemeColor.text.color, textAlignment: self.textAlignment)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = self.textAlignment
        label.textColor = ThemeColor.primary.color
        let text = NSMutableAttributedString(string: "$0", attributes: [
            .font: ThemeFont.bold(ofSize: 24.0)
        ])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16.0)], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel, amountLabel
        ])
        view.axis = .vertical
        return view
    }()
    
    init(title: String, textAlignment: NSTextAlignment) {
        self.title = title
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        let text = NSMutableAttributedString(string: "$\(text)", attributes: [
            .font: ThemeFont.bold(ofSize: 24.0)
        ])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16.0)], range: NSMakeRange(0, 1))
        amountLabel.attributedText = text
    }
    
    private func layout() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
