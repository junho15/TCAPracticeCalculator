import ComposableArchitecture

@Reducer
struct CalculatorFeature {
    @ObservableState
    struct State: Equatable {
        static func == (lhs: CalculatorFeature.State, rhs: CalculatorFeature.State) -> Bool {
            lhs.currentValue == rhs.currentValue && lhs.inputValue == rhs.inputValue
        }
        
        var currentValue: Int = 0
        var inputValue: Int = 0
        var pendingOperation: ((Int, Int) -> Int)?
        
        let maxInputDigits: Int = 9
    }
    
    enum Action {
        case numberButtonTapped(Int)
        case plusButtonTapped
        case minusButtonTapped
        case returnButtonTapped
        case clearButtonTapped
        case toggleSignButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .numberButtonTapped(let number):
                let newInputValue = state.inputValue * 10 + number
                if String(newInputValue).count <= state.maxInputDigits {
                    state.inputValue = newInputValue
                }
                return .none
                
            case .plusButtonTapped:
                state.currentValue = state.inputValue
                state.inputValue = 0
                state.pendingOperation = (+)
                return .none
                
            case .minusButtonTapped:
                state.currentValue = state.inputValue
                state.inputValue = 0
                state.pendingOperation = (-)
                return .none
                
            case .returnButtonTapped:
                if let operation = state.pendingOperation {
                    state.inputValue = operation(state.currentValue, state.inputValue)
                    state.pendingOperation = nil
                }
                return .none
                
            case .clearButtonTapped:
                state.currentValue = 0
                state.inputValue = 0
                state.pendingOperation = nil
                return .none
                
            case .toggleSignButtonTapped:
                state.inputValue = -state.inputValue
                return .none
            }
        }
    }
}
