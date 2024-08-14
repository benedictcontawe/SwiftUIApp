//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI
import SwiftData

struct NavigationView : View {
    @EnvironmentObject var viewModel : ViewModel
    var body : some View {
        NavigationStack {
            ZStack {
                /*
                Group {
                    switch viewModel.selectedPage {
                    case "Home":
                        HomeView()
                    case "Profile":
                        ProfileView()
                    case "Settings":
                        SettingsView()
                    default:
                        DefaultView()
                    }
                }
                */
                ContentView(text: viewModel.selectedPage)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                SideMenuView()
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
    NavigationView()
}
