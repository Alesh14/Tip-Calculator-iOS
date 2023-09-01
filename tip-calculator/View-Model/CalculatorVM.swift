//
//  CalculatorVM.swift
//  tip-calculator
//
//  Created by Alisher Manatbek on 26.08.2023.
//

import Combine
import Foundation

class CalculatorVM {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    private var cancelables = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {

        let updateViewPublisher = Publishers.CombineLatest3(input.billPublisher, input.tipPublisher, input.splitPublisher).flatMap { [unowned self] (bill, tip, split) in
            let totalTip = getTipAmount(bill: bill, tip: tip)
            let totalBill = bill + totalTip
            let amoutPerPerson = totalBill / Double(split)
            let result = Result(amountPerson: amoutPerPerson, totalBill: totalBill, totalTip: totalTip)
            return Just(result)
        }.eraseToAnyPublisher()
        
        
        return Output(updateViewPublisher: updateViewPublisher)
        
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value) / 100.0
        }
    }
    
}
