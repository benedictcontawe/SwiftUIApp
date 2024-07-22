//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @ObservedObject var viewModel : ViewModel = ViewModel()

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.getData())
                ProgressView(value: viewModel.getProgressData(), total: 10)
            }.fixedSize(horizontal: false, vertical: false)
            Divider()
            Button (
                action: {
                    viewModel.setData(data: "Button was Clicked")
                }
            ) {
                Text("Send Data")
            }
            Toggle("Toggle", isOn: $viewModel.toggleState).onChange(of: viewModel.toggleState) { oldValue, newValue in
                viewModel.setSwitchChecked(isChecked: newValue)
            }
            Picker(
                selection: $viewModel.pickerState,
                label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/
            ) {
                /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                Text("2").tag(2)
            }.onChange(of: viewModel.pickerState) { oldValue, newValue in
                viewModel.setData(data: "Picker set to \(newValue)")
            }.pickerStyle(.automatic)
            Stepper(
                value: $viewModel.stepperState,
                in: 0...10
            ) {
                Text("Stepper \(viewModel.stepperState)")
            }.onChange(of: viewModel.stepperState) { oldValue, newValue in
                viewModel.setData(data: "Stepper set to \(newValue)")
                viewModel.setProgressData(progressData: Float(newValue))
            }
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
        }
        .frame(maxHeight: .infinity)
        
    }
}

#Preview {
    ContentView().modelContainer(for: Item.self, inMemory: true)
}
