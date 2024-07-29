//
//  BottomNavigationView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/29/24.
//
import SwiftUI

struct BottomNavigationView: View {
    @ObservedObject var viewModel : ViewModel = ViewModel()
    var body: some View {
        TabView {
            List(Array(viewModel.models.enumerated()), id: \.element.id) { index, model in
                ContentView(
                    text: model.text,
                    image: model.image
                ).tabItem {
                    Image(systemName: model.image)
                    Text(model.text)
                }
            }
        }
    }
}

#Preview {
    BottomNavigationView()
}
