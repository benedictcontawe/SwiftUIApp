//
//  BottomNavigationView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/29/24.
//
import SwiftUI

struct BottomNavigationView: View {
    @ObservedObject var viewModel : ViewModel = ViewModel()
    @State private var selectedIndex: Int = 0
    var body: some View {
        TabView (
            selection: $selectedIndex,
            content: {
                ForEach(viewModel.models.indices, id: \.self) { index in
                    let model = viewModel.models[index]
                    ContentView(
                        text: model.text,
                        image: model.image,
                        index: index
                    )
                    .tabItem {
                        VStack {
                            Image(systemName: model.image)
                            Text(model.text)
                        }
                    }
                    .tag(index)
                }
            }
        )
        .onAppear(perform: {
            UITabBar.appearance().unselectedItemTintColor = .systemBrown
            UITabBarItem.appearance().badgeColor = .systemPink
            UITabBar.appearance().backgroundColor = .systemGray4.withAlphaComponent(0.4)
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemPink]
        })
    }
}

#Preview {
    BottomNavigationView()
}
