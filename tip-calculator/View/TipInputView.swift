//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Alisher Manatbek on 20.08.2023.
//

import UIKit

class TipInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Choose", bottomText: "your tip")
        return view
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        buildTipButton(tip: .tenPercent)
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        buildTipButton(tip: .fifteenPercent)
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        buildTipButton(tip: .twentyPercent)
    }()
    
    private lazy var customTip: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20.0)
        button.backgroundColor = ThemeColor.primary.color
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        return button
    }()
    
    private lazy var buttonHStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            tenPercentTipButton, fifteenPercentTipButton, twentyPercentTipButton
        ])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 16.0
        return view
    }()
    
    private lazy var buttonVStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            buttonHStackView, customTip
        ])
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 16.0
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [headerView, buttonVStackView].forEach(addSubview(_:))
        
        buttonVStackView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(buttonHStackView.snp.centerY)
            $0.width.equalTo(68.0)
            $0.trailing.equalTo(buttonVStackView.snp.leading).offset(-24.0)
        }
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton()
        button.backgroundColor = ThemeColor.primary.color
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(string: tip.stringValue, attributes: [
            .font: ThemeFont.bold(ofSize: 20.0),
            .foregroundColor: UIColor.white
        ])
        text.addAttributes([
            .font: ThemeFont.demibold(ofSize: 14.0)
        ], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
    
}
