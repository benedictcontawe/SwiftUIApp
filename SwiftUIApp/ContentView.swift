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
    @State private var toggleState : Bool = true
    @State private var pickerState : Int = 0
    @State private var stepperState : Int = 5
    @State private var sliderState : Float = 5.0

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.getData())
                ProgressView(value: viewModel.getProgressData())
            }.fixedSize(horizontal: false, vertical: false)
            Divider()
            Button (
                action: {
                    viewModel.setData(data: "Button was Clicked")
                }
            ) {
                Text("Send Data")
            }
            Toggle("Toggle", isOn: $toggleState).onChange(of: toggleState) { oldValue, newValue in
                viewModel.setSwitchChecked(isChecked: newValue)
            }
            Picker(
                selection: $pickerState,
                label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/
            ) {
                /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                Text("2").tag(2)
            }.onChange(of: pickerState) { oldValue, newValue in
                viewModel.setData(data: "Picker set to \(newValue)")
            }.pickerStyle(.automatic)
            Stepper(
                value: $stepperState,
                in: 0...10
            ) {
                Text("Stepper \(stepperState)")
            }.onChange(of: stepperState) { oldValue, newValue in
                viewModel.setData(data: "Stepper set to \(newValue)")
            }
            Slider(
                value: $sliderState,
                in: 0...10,
                step: 1,
                onEditingChanged: { data in
                    
                },
                minimumValueLabel: Text("0"),
                maximumValueLabel: Text("10"),
                label: {
                    Text("Slider")
                }
            ).onChange(of: sliderState) { oldValue, newValue in
                viewModel.setData(data: "Slider set to \(newValue)")
            }
        }
        .frame(maxHeight: .infinity)
        
    }
}

#Preview {
    ContentView().modelContainer(for: Item.self, inMemory: true)
}
