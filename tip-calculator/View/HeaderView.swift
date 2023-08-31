//
//  HeaderView.swift
//  tip-calculator
//
//  Created by Alisher Manatbek on 26.08.2023.
//

import UIKit

class HeaderView: UIView {
    
    private let topLabel: UILabel = {
        LabelFactory.build(text: nil, font: ThemeFont.bold(ofSize: 18))
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(text: nil, font: ThemeFont.regular(ofSize: 18))
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var container: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            topSpacerView, topLabel, bottomLabel, bottomSpacerView
        ])
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = -4
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(container)
        
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints {
            $0.height.equalTo(bottomSpacerView)
        }
    }
    
    func configure(topText: String, bottomText: String) {
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
    
}
