//
//  ResultView.swift
//  tip-calculator
//
//  Created by Alisher Manatbek on 20.08.2023.
//

import UIKit

class ResultView: UIView {
    
    private let headerLabel: UILabel = {
        LabelFactory.build(text: "Total p/person", font: ThemeFont.demibold(ofSize: 18))
    }()
    
    private let amountPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(string: "$0.0", attributes: [
            .font: ThemeFont.bold(ofSize: 48)
        ])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private let hLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator.color
        return view
    }()
    
    private let totalBillView: AmountView = {
        let view = AmountView(title: "Total bill", textAlignment: .left)
        return view
    }()
    
    private let totalTipView: AmountView = {
        let view = AmountView(title: "Total tip", textAlignment: .right)
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            totalBillView, UIView(), totalTipView
        ])
        view.axis = .horizontal
        view.distribution = .fillEqually
        
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            headerLabel, amountPersonLabel, hLineView, buildSpacerView(height: 0), hStackView
        ])
        view.axis = .vertical
        view.spacing = 8.0
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: Result) {
        let text = NSMutableAttributedString(string: "$\(result.amountPerson.stringValue)", attributes: [
            .font: ThemeFont.bold(ofSize: 48.0)
        ])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 24.0)
        ], range: NSMakeRange(0, 1))
        amountPersonLabel.attributedText = text
        
        totalTipView.configure(text: result.totalTip.stringValue)
        totalBillView.configure(text: result.totalBill.stringValue)
    }
    
    private func layout() {
        backgroundColor = .white
        
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(24)
            $0.bottom.trailing.equalToSuperview().offset(-24)
        }
        
        hLineView.snp.makeConstraints {
            $0.height.equalTo(2)
        }
        
        addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: height)
        ])
        return view
    }
    
}
