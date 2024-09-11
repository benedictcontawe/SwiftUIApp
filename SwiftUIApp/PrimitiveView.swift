//
//  PrimitiveView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/11/24.
//

import SwiftUI

struct PrimitiveView: View {
    @State private var booleanValue: Bool = false
    @State private var stringValue: String = ""
    @State private var integerValue: String = ""
    @State private var doubleValue: String = ""
    var body: some View {
        GeometryReader { geometry in
            VStack {
                AppBar()
                Spacer()
                HStack {
                    Toggle(isOn: $booleanValue) {
                        Text("Boolean Value:")
                    }
                    Spacer()
                    CustomButtonWidget(text: "Update") {
                        print("Update Boolean tapped")
                    }
                    Spacer()
                    Text("Boolean Value")
                }
                Spacer()
                HStack {
                    TextField("Enter String Value", text: $stringValue)
                      .textFieldStyle(.roundedBorder)
                      .keyboardType(.default)
                      .disableAutocorrection(true)
                    Spacer()
                    CustomButtonWidget(text: "Update") {
                        print("Update String tapped")
                    }
                    Spacer()
                    Text("String Value")
                }
                Spacer()
                HStack {
                    TextField("Enter Integer Value", text: $integerValue)
                      .textFieldStyle(.roundedBorder)
                      .keyboardType(.numberPad)
                      .disableAutocorrection(true)
                    Spacer()
                    CustomButtonWidget(text: "Update") {
                        print("Update Integer tapped")
                    }
                    Spacer()
                    Text("Integer Value")
                }
                Spacer()
                HStack {
                    TextField("Enter Double Value", text: $doubleValue)
                      .textFieldStyle(.roundedBorder)
                      .keyboardType(.numberPad)
                      .disableAutocorrection(true)
                    Spacer()
                    CustomButtonWidget(text: "Update") {
                        print("Update Double tapped")
                    }
                    Spacer()
                    Text("Double Value")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    PrimitiveView()
}
