//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        GeometryReader { geometry in
            let horizontalPadding = geometry.size.width * 0.05
            VStack {
                Spacer()
                HStack {
                    Text(viewModel.getData())
                    ProgressView(value: viewModel.getProgressData(), total: 10)
                }
                Spacer()
                Divider()
                Spacer()
                Button (
                    action: {
                        viewModel.setData(data: "Button was Clicked")
                    }
                ) {
                    Text("Send Data")
                }
                Spacer()
                Toggle("Toggle", isOn: $viewModel.toggleState).onChange(of: viewModel.toggleState) { oldValue, newValue in
                    viewModel.setSwitchChecked(isChecked: newValue)
                }
                Spacer()
                Picker(
                    selection: $viewModel.pickerState,
                    label: Text("Picker")
                ) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                }.onChange(of: viewModel.pickerState) { oldValue, newValue in
                    viewModel.setData(data: "Picker set to \(newValue)")
                }.pickerStyle(.automatic)
                Spacer()
                Stepper(
                    value: $viewModel.stepperState,
                    in: 0...10
                ) {
                    Text("Stepper \(viewModel.stepperState)")
                }.onChange(of: viewModel.stepperState) { oldValue, newValue in
                    viewModel.setData(data: "Stepper set to \(newValue)")
                    viewModel.setProgressData(progressData: Float(newValue))
                }
                Spacer()
                Slider(
                    value: $viewModel.sliderState,
                    in: 0...10,
                    step: 1,
                    onEditingChanged: { data in
                    
                    },
                    minimumValueLabel: Text("0"),
                    maximumValueLabel: Text("10"),
                    label: {
                        Text("Slider")
                    }
                ).onChange(of: viewModel.sliderState) { oldValue, newValue in
                    viewModel.setData(data: "Slider set to \(newValue)")
                    viewModel.setProgressData(progressData: newValue)
                }
                Spacer()
            }
            .padding(.leading, horizontalPadding)
            .padding(.trailing, horizontalPadding)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView().modelContainer(for: Item.self, inMemory: true)
}
