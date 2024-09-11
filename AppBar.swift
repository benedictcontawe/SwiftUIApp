//
//  AppBar.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/11/24.
//

import SwiftUI

struct AppBar: View {
    var body: some View {
        HStack {
            Text("Swift App")
            .font(.custom("avenir", size: 32))
            .fontWeight(.black)
            Spacer()
        }
        .padding()
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    AppBar()
}
