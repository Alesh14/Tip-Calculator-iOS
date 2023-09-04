//
//  CalculatorViewController.swift
//  tip-calculator
//
//  Created by Alisher Manatbek on 20.08.2023.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class CalculatorViewController: UIViewController {

    private let logoView: LogoView = {
        LogoView()
    }()
    
    private let resultView: ResultView = {
       ResultView()
    }()
    
    private let billInputView: BillInputView = {
        BillInputView()
    }()
    
    private let tipInputView: TipInputView = {
       TipInputView()
    }()
    
    private let splitInputView: SplitInputView = {
       SplitInputView()
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            logoView, resultView, billInputView, tipInputView, splitInputView, UIView()
        ])
        view.axis = .vertical
        view.spacing = 36.0
        return view
    }()
    
    private let viewmodel = CalculatorVM()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.numberOfTapsRequired = 2
        logoView.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ThemeColor.background.color
        configure()
        bind()
        observe()
    }
    
    private func observe() {
        viewTapPublisher.sink { [unowned self] in
            view.endEditing(true)
        }.store(in: &cancellables)
    }
    
    private func bind() {
        
        let input = CalculatorVM.Input(billPublisher: billInputView.valuePublisher, tipPublisher: tipInputView.valuePublisher, splitPublisher: splitInputView.valuePublisher, logoViewTapPublisher: logoViewTapPublisher)
        
        let output = viewmodel.transform(input: input)
        
        output.updateViewPublisher.sink { [unowned self] result in
            resultView.configure(result: result)
        }.store(in: &cancellables)
        
        output.resetCalculatorPublisher.sink { [unowned self] _ in
            tipInputView.reset()
            billInputView.reset()
            splitInputView.reset()
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 5.0, initialSpringVelocity: 0.5, options: .curveEaseInOut,
            animations: { [unowned self] in
                logoView.transform = .init(scaleX: 1.5, y: 1.5)
            }, completion: { _ in
                UIView.animate(withDuration: 0.1) { [unowned self] in
                    logoView.transform = .identity
                }
            })
        }.store(in: &cancellables)
        
    }
    
    private func configure() {
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leadingMargin).offset(16.0)
            $0.trailing.equalTo(view.snp.trailingMargin).offset(-16.0)
            $0.top.equalTo(view.snp.topMargin).offset(16.0)
            $0.bottom.equalTo(view.snp.bottomMargin).offset(-16.0)
        }
        
        logoView.snp.makeConstraints {
            $0.height.equalTo(48.0)
        }
        
        resultView.snp.makeConstraints {
            $0.height.equalTo(224.0)
        }
        
        billInputView.snp.makeConstraints {
            $0.height.equalTo(56.0)
        }
        
        tipInputView.snp.makeConstraints {
            $0.height.equalTo(2 * 56 + 16)
        }
        
        splitInputView.snp.makeConstraints {
            $0.height.equalTo(56.0)
        }
    }

}

