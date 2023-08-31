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
        
        input.billPublisher.sink { bill in
            print("the bill \(bill)")
        }.store(in: &cancelables)
        
        let result = Result(amountPerson: 500, totalBill: 1000, totalTip: 50.0)
        
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
        
    }
    
}
