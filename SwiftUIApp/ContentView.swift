//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel : ViewModel = ViewModel()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                List(Array(viewModel.getModels().enumerated()), id: \.element.id) { index, model in
                    // Your row content here
                    Text("\(index): \(model.name)")
                }
                FloatingActionButtons (
                    lead: geometry.size.width * 0.10,
                    trail: geometry.size.width * 0.90,
                    bottom: geometry.size.height * 0.95,
                    addAction: {
                        viewModel.showAlert.toggle()
                        //viewModel.showActionSheet.toggle()
                        //viewModel.showSheet.toggle()
                    },
                    clearAction: {
                        viewModel.clearModel()
                    }
                )
            }.alert(
                isPresented: $viewModel.showAlert,
                content: {
                    Alert(
                        title: Text("Alert Title"),
                        message: Text("Alert Message."),
                        primaryButton: .default(Text("OK")),
                        secondaryButton: .cancel()
                    )
                }
            ).confirmationDialog("Confimation Dialog", isPresented: $viewModel.showActionSheet, titleVisibility: .visible) {
                Button("Option 1") {
                                    // Handle option 1
                }
                Button("Option 2") {
                    // Handle option 2
                }
                Button("Cancel", role: .cancel) {
                    
                }
            }.sheet(isPresented: $viewModel.showSheet) {
                VStack {
                    Text("Custom Sheet")
                        .font(.headline)
                    Button("Dismiss") {
                        viewModel.showSheet = false
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    ContentView().modelContainer(for: Item.self, inMemory: true)
}
