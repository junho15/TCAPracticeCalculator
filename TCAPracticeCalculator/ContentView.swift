import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<CalculatorFeature>
    
    var body: some View {
        VStack(spacing: 12) {
            Text("\(store.inputValue)")
                .font(.largeTitle)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
            
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    calculatorButton("1", action: .numberButtonTapped(1))
                    calculatorButton("2", action: .numberButtonTapped(2))
                    calculatorButton("3", action: .numberButtonTapped(3))
                    calculatorButton("+", action: .plusButtonTapped)
                }
                HStack(spacing: 12) {
                    calculatorButton("4", action: .numberButtonTapped(4))
                    calculatorButton("5", action: .numberButtonTapped(5))
                    calculatorButton("6", action: .numberButtonTapped(6))
                    calculatorButton("-", action: .minusButtonTapped)
                }
                HStack(spacing: 12) {
                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            calculatorButton("7", action: .numberButtonTapped(7))
                            calculatorButton("8", action: .numberButtonTapped(8))
                            calculatorButton("9", action: .numberButtonTapped(9))
                        }
                        HStack(spacing: 12) {
                            calculatorButton("±", action: .toggleSignButtonTapped)
                            calculatorButton("0", action: .numberButtonTapped(0))
                            calculatorButton("C", action: .clearButtonTapped)
                        }
                    }
                    calculatorButton("=", action: .returnButtonTapped, style: .return)
                }
            }
            .font(.largeTitle)
            .padding()
        }
        .padding()
    }
    
    @ViewBuilder
    private func calculatorButton(_ title: String, action: CalculatorFeature.Action, style: CalculatorButtonStyle = .normal) -> some View {
        Button(title) {
            store.send(action)
        }
        .buttonStyle(style)
    }
}

enum CalculatorButtonStyle: ButtonStyle {
    case normal
    case `return`
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 70, height: self == .return ? 152 : 70)
            .background(Color.blue.opacity(configuration.isPressed ? 0.5 : 1.0))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

#Preview {
    ContentView(store: Store(
        initialState: CalculatorFeature.State(),
        reducer: {
            CalculatorFeature()
        }
    ))
}
