//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/28/24.
//

import SwiftUI

struct ContentView : View {
    let text : String
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(text)
        }
    }
}

#Preview {
    ContentView(text: "Hello World")
}
