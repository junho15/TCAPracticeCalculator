import XCTest
import ComposableArchitecture

@testable import TCAPracticeCalculator

final class CalculatorFeatureTests: XCTestCase {
    
    @MainActor
    func testNumberButtonTapped() async {
        let store = TestStore(initialState: CalculatorFeature.State()) {
            CalculatorFeature()
        }

        await store.send(.numberButtonTapped(1)) {
            $0.inputValue = 1
        }

        await store.send(.numberButtonTapped(2)) {
            $0.inputValue = 12
        }
        
        await store.send(.numberButtonTapped(3)) {
            $0.inputValue = 123
        }
    }
    
    @MainActor
    func testPlusButtonTapped() async {
        let store = TestStore(initialState: CalculatorFeature.State(inputValue: 123)) {
            CalculatorFeature()
        }

        await store.send(.plusButtonTapped) {
            $0.currentValue = 123
            $0.inputValue = 0
            $0.pendingOperation = (+)
        }

        await store.send(.numberButtonTapped(7)) {
            $0.inputValue = 7
        }

        await store.send(.returnButtonTapped) {
            $0.inputValue = 130
            $0.pendingOperation = nil
        }
    }
    
    @MainActor
    func testMinusButtonTapped() async {
        let store = TestStore(initialState: CalculatorFeature.State(inputValue: 100)) {
            CalculatorFeature()
        }

        await store.send(.minusButtonTapped) {
            $0.currentValue = 100
            $0.inputValue = 0
            $0.pendingOperation = (-)
        }

        await store.send(.numberButtonTapped(30)) {
            $0.inputValue = 30
        }

        await store.send(.returnButtonTapped) {
            $0.inputValue = 70
            $0.pendingOperation = nil
        }
    }
    
    @MainActor
    func testClearButtonTapped() async {
        let store = TestStore(
            initialState: CalculatorFeature.State(currentValue: 123, inputValue: 456)
        ) {
            CalculatorFeature()
        }

        await store.send(.clearButtonTapped) {
            $0.currentValue = 0
            $0.inputValue = 0
            $0.pendingOperation = nil
        }
    }
    
    @MainActor
    func testToggleSignButtonTapped() async {
        let store = TestStore(initialState: CalculatorFeature.State(inputValue: 123)) {
            CalculatorFeature()
        }

        await store.send(.toggleSignButtonTapped) {
            $0.inputValue = -123
        }

        await store.send(.toggleSignButtonTapped) {
            $0.inputValue = 123
        }
    }
    
    @MainActor
    func testMaxInputDigitsLimit() async {
        let store = TestStore(initialState: CalculatorFeature.State(inputValue: 123456789)) {
            CalculatorFeature()
        }

        await store.send(.numberButtonTapped(9))
        store.assert { state in
            state.inputValue = 123456789
        }
    }
}
