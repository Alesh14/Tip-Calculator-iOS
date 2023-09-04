//
//  tip_calculatorTests.swift
//  tip-calculatorTests
//
//  Created by Alisher Manatbek on 20.08.2023.
//

import XCTest
import Combine
@testable import tip_calculator

final class tip_calculatorTests: XCTestCase {

    // SUT -> System Under Test
    private var sut: CalculatorVM!
    private var cancellables: Set<AnyCancellable>!
    
    private let logoViewTapInput = PassthroughSubject<Void, Never>()
    
    override func setUp() {
        sut = .init()
        cancellables = .init()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
    }
    
    func testResultsWithoutTipForPerson() {
        // given
        let bill: Double = 100.0
        let tip: Tip = .none
        let quantity: Int = 1
        let input = buildInput(bill: bill, tip: tip, quantity: quantity)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerson, 100.0)
            XCTAssertEqual(result.totalBill, 100.0)
            XCTAssertEqual(result.totalTip, 0.0)
        }.store(in: &cancellables)
    }
    
    private func buildInput(bill: Double, tip: Tip, quantity: Int) -> CalculatorVM.Input {
        return .init(billPublisher: Just(bill).eraseToAnyPublisher(), tipPublisher: Just(tip).eraseToAnyPublisher(), splitPublisher: Just(quantity).eraseToAnyPublisher(), logoViewTapPublisher: logoViewTapInput.eraseToAnyPublisher())
    }
    
}
