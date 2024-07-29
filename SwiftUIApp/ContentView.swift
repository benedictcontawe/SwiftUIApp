//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/28/24.
//

import SwiftUI

struct ContentView : View {
    let text : String
    let image : String
    let index : Int
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: image)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text(text)
            }
            .navigationTitle(text)
        }
        .tag(index)
    }
}

#Preview {
    ContentView(text: "Hello World", image: "globe", index: 0)
}
