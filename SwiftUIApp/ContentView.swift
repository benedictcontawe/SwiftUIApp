//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var progressState : Double = 0.5
    @State private var toggleState : Bool = true
    @State private var stepperState : Int = 5
    @State private var sliderState : Float = 5.0

    var body: some View {
        VStack {
            HStack {
                Text(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/)
                ProgressView(value: progressState)
            }.fixedSize(horizontal: false, vertical: false)
            Divider()
            Button (
                action: {
                    
                }
            ) {
                Text("Send Data")
            }
            Toggle("Toggle", isOn: $toggleState)
            Picker(
                selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/,
                label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/
            ) {
                /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                Text("2").tag(2)
            }.pickerStyle(.automatic)
            Stepper(
                value: $stepperState,
                in: 0...10
            ) {
                Text("Stepper")
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
            )
        }
        .frame(maxHeight: .infinity)
        
    }
}

#Preview {
    ContentView().modelContainer(for: Item.self, inMemory: true)
}
