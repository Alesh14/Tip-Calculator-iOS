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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ThemeColor.background.color
        configure()
        bind()
    }
    
    private func bind() {
        
        let input = CalculatorVM.Input(billPublisher: billInputView.valuePublisher, tipPublisher: Just(.tenPercent).eraseToAnyPublisher(), splitPublisher: Just(5).eraseToAnyPublisher())
        
        let output = viewmodel.transform(input: input)
        
        output.updateViewPublisher.sink { result in
            print(result)
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

