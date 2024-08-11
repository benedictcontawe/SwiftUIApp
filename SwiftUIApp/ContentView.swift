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
                        cellAction: {
                            viewModel.selectedIndex = index
                            viewModel.showActionSheet.toggle()
                        },
                        editAction: {
                            viewModel.selectedIndex = index
                            viewModel.editText = model.name
                            viewModel.showEditSheet.toggle()
                        },
                        deleteAction: {
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
                        viewModel.addText?.removeAll()
                        viewModel.showAddSheet.toggle()
                    },
                    clearAction: {
                        viewModel.showClearAlert.toggle()
                    }
                )
            }.alert(
                isPresented: $viewModel.showClearAlert,
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
                Button("Add New") {
                    viewModel.addText?.removeAll()
                    viewModel.showAddSheet.toggle()
                }
                Button("Edit") {
                    viewModel.setEditText()
                    viewModel.showEditSheet.toggle()
                }
                Button("Cancel", role: .cancel) {
                    
                }
            }.sheet(isPresented: $viewModel.showAddSheet) {
                VStack {
                    Text("Add New")
                        .font(.headline)
                    TextField(
                        "Enter your text",
                        text: Binding(
                            get: { viewModel.addText ?? "" },
                            set: { viewModel.addText = $0 }
                        )
                    )
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    Button("Add") {
                        viewModel.showAddSheet = false
                        viewModel.addModel()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }.sheet(isPresented: $viewModel.showEditSheet) {
                VStack {
                    Text("Edit Name")
                        .font(.headline)
                    TextField(
                        "Enter your text",
                        text: Binding(
                            get: { viewModel.editText ?? "" },
                            set: { viewModel.editText = $0 }
                        )
                    )
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    Button("Edit") {
                        viewModel.showEditSheet = false
                        viewModel.editModel()
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
