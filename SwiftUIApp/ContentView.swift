//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        GeometryReader { geometry in
            //let horizontalPadding = geometry.size.width * 0.025
            ZStack {
                List(Array(viewModel.models .enumerated()), id: \.offset) { index, model in
                    CardCell(
                        index: index,
                        image: model.image,
                        title: model.title,
                        explanation: model.explanation,
                        date: model.date,
                        copyright: model.copyright
                    )
                }.refreshable {
                    await viewModel.requestAPOD()
                }
                //.padding(.leading, horizontalPadding)
                //.padding(.trailing, horizontalPadding)
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear() {
                Task {
                    await viewModel.requestAPOD()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
