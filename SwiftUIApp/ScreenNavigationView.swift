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
                NavigationLink(destination: RegisterView()) {
                    Text("Go to Register")
                }
                NavigationLink(destination: LoginView()) {
                    Text("Go to Login")
                }
            }
            .navigationTitle("Main Screen")
        }
    }
}
