//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Alisher Manatbek on 20.08.2023.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    
    private var cancelables = Set<AnyCancellable>()
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Choose", bottomText: "your tip")
        return view
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button.tapPublisher.flatMap {
            return Just(Tip.tenPercent)
        }
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancelables)
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        button.tapPublisher.flatMap {
            return Just(Tip.fifteenPercent)
        }
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancelables)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.tapPublisher.flatMap {
            return Just(Tip.twentyPercent)
        }
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancelables)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20.0)
        button.backgroundColor = ThemeColor.primary.color
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        button.tapPublisher.sink { [unowned self] _ in
            self.handleCustomTipButton()
        }.store(in: &cancelables)
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
            buttonHStackView, customTipButton
        ])
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 16.0
        return view
    }()
    
    private let tipSubject: CurrentValueSubject<Tip, Never> = .init(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
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
    
    private func handleCustomTipButton() {
        let alertController: UIAlertController = {
            let controller = UIAlertController(title: "Enter custom tip", message: nil, preferredStyle: .alert)
            
            controller.addTextField { textField in
                textField.placeholder = "Make it genorous!"
                textField.keyboardType = .decimalPad
                textField.autocorrectionType = .no
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
                guard let text = controller.textFields?.first?.text, let value = Int(text) else { return }
                self.tipSubject.send(.custom(value: value))
            }
            
            [okAction, cancelAction].forEach(controller.addAction(_:))
            
            return controller
        }()
        
        parentViewController?.present(alertController, animated: true)
    }
    
    private func observe() {
        tipSubject.sink { [unowned self] tip in
            self.resetView()
            switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentTipButton.backgroundColor = ThemeColor.secondary.color
            case .fifteenPercent:
                fifteenPercentTipButton.backgroundColor = ThemeColor.secondary.color
            case .twentyPercent:
                twentyPercentTipButton.backgroundColor = ThemeColor.secondary.color
            case .custom(let value):
                customTipButton.backgroundColor = ThemeColor.secondary.color
                let text = NSMutableAttributedString(string: "$\(value)", attributes: [
                    .font: ThemeFont.bold(ofSize: 20.0)
                ])
                text.addAttributes([
                    .font: ThemeFont.bold(ofSize: 14.0)
                ], range: NSMakeRange(0, 1))
                customTipButton.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancelables)
    }
    
    private func resetView() {
        [tenPercentTipButton, fifteenPercentTipButton, twentyPercentTipButton, customTipButton].forEach { button in
            button.backgroundColor = ThemeColor.primary.color
        }
        let text = NSMutableAttributedString(string: "Custom tip", attributes: [
            .font: ThemeFont.bold(ofSize: 20.0)
        ])
        customTipButton.setAttributedTitle(text, for: .normal)
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
