//
//  MainView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/11/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel : MainViewModel = MainViewModel()
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                HStack(alignment: .center,spacing: CGFloat(geometry.size.width * 0.025)) {
                    CustomButtonWidget(text: "Primitive") {
                        print("Go to Primitive tapped")
                    }
                    .frame(maxWidth: .infinity)
                    CustomButtonWidget(text: "Object") {
                        print("Go to Object tapped")
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding(.top, geometry.size.height * 0.05)
            .edgesIgnoringSafeArea(.top)
            .padding(.leading, geometry.size.width * 0.05)
            .padding(.trailing, geometry.size.width * 0.05)
        }
    }
}

#Preview {
    MainView()
}
