//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by Alisher Manatbek on 20.08.2023.
//

import UIKit

class SplitInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Split", bottomText: "the total")
        return view
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(text: "-", corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(text: "+", corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        return button
    }()
    
    private lazy var quantityCountLabel: UILabel = {
        let label = LabelFactory.build(text: "1", font: ThemeFont.bold(ofSize: 20))
        return label
    }()
    
    private lazy var container: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            decrementButton, quantityCountLabel, incrementButton
        ])
        view.axis = .horizontal
        view.spacing = 0
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
        [headerView, container].forEach(addSubview(_:))
        
        container.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(container.snp.centerY)
            $0.width.equalTo(68.0)
            $0.trailing.equalTo(container.snp.leading).offset(-24.0)
        }
        
        [incrementButton, decrementButton].forEach { button in
            button.snp.makeConstraints {
                $0.width.equalTo(button.snp.height)
            }
        }
    }
    
    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.backgroundColor = ThemeColor.primary.color
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20.0)
        button.addRoundedCorners(corners: corners, radius: 8.0)
        return button
    }
    
} 
