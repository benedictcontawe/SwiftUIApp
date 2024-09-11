//
//  NavigationView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/11/24.
//

import SwiftUI

struct ScreenNavigationView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: LoginView()) {
                    Text("Go to Login")
                }
                NavigationLink(destination: RegisterView()) {
                    Text("Go to Register")
                }
                NavigationLink(destination: MainView()) {
                    Text("Go to Main")
                }
                NavigationLink(destination: PrimitiveView()) {
                    Text("Go to Primitive")
                }
                NavigationLink(destination: ObjectView()) {
                    Text("Go to Object")
                }
            }
            .navigationTitle("SwiftUI App")
        }
    }
}
