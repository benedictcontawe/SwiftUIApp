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
        NavigationStack {
            ZStack {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello World")
                }
                SideMenuView(isShowing: $viewModel.showMenu, models: $viewModel.models)
            }
            .toolbar(viewModel.showMenu ? .hidden : .visible, for: .navigationBar)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        viewModel.showMenu.toggle()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                    } )
                }
            }
        }
        .frame(maxHeight: .infinity)
        
    }
}

#Preview {
    ContentView()
}
