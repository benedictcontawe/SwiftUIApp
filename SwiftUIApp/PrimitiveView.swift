//
//  PrimitiveView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/11/24.
//

import SwiftUI

struct PrimitiveView: View {
    @ObservedObject var viewModel : PrimitiveViewModel = PrimitiveViewModel()
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Toggle(isOn: $viewModel.toggleValue) {
                        Text("Boolean Value: \(viewModel.getToggle())")
                    }
                    Spacer()
                    CustomButtonWidget(text: "Update") {
                        viewModel.onUpdateBoolean()
                    }
                    Spacer()
                    Text("\(viewModel.getBoolean())")
                }
                Spacer()
                HStack {
                    TextField("Enter String Value", text: $viewModel.stringTextValue)
                      .textFieldStyle(.roundedBorder)
                      .keyboardType(.default)
                      .disableAutocorrection(true)
                    Spacer()
                    CustomButtonWidget(text: "Update") {
                        viewModel.onUpdateString()
                    }
                    Spacer()
                    Text("\(viewModel.stringValue)")
                }
                Spacer()
                HStack {
                    TextField("Enter Integer Value", text: viewModel.integerTextValueBinding)
                      .textFieldStyle(.roundedBorder)
                      .keyboardType(.numberPad)
                      .disableAutocorrection(true)
                    Spacer()
                    CustomButtonWidget(text: "Update") {
                        viewModel.onUpdateInteger()
                    }
                    Spacer()
                    Text("\(viewModel.integerValue.description)")
                }
                Spacer()
                HStack {
                    TextField("Enter Double Value", text: viewModel.getDoubleText())
                      .textFieldStyle(.roundedBorder)
                      .keyboardType(.numberPad)
                      .disableAutocorrection(true)
                    Spacer()
                    CustomButtonWidget(text: "Update") {
                        viewModel.onUpdateDouble()
                    }
                    Spacer()
                    Text("\(viewModel.doubleValue)")
                }
                Spacer()
            }
        }.onAppear {
            viewModel.fetchData()
        }
    }
}

#Preview {
    PrimitiveView()
}
