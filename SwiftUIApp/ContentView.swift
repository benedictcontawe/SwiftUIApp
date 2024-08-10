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
                    CardCell(
                        index: index,
                        name: model.name,
                        editAction: { index in
                            //TODO: Edit Functionality
                        },
                        deleteAction: { index in
                            withAnimation(.linear) {
                                viewModel.clearModel(index: index)
                            }
                        }
                    )
                }
                FloatingActionButtons (
                    lead: geometry.size.width * 0.10,
                    trail: geometry.size.width * 0.90,
                    bottom: geometry.size.height * 0.95,
                    addAction: {
                        //viewModel.showActionSheet.toggle()
                        viewModel.addText.removeAll()
                        viewModel.showSheet.toggle()
                    },
                    clearAction: {
                        viewModel.showAlert.toggle()
                    }
                )
            }.alert(
                isPresented: $viewModel.showAlert,
                content: {
                    Alert(
                        title: Text("Clear Prompt"),
                        message: Text("Are you sure you want to Clear All."),
                        primaryButton: .default(Text("OK"), action: {
                            withAnimation(.bouncy) {
                                viewModel.clearModel()
                            }
                        }),
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
                    TextField("Enter your text", text: $viewModel.addText)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                    Button("Add") {
                        viewModel.showSheet = false
                        viewModel.addModel()
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
