//
//  SideMenuView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/23/24.
//

import SwiftUI

struct SideMenuView : View {
    @ObservedObject var viewModel : ViewModel
    var body: some View {
        ZStack {
            if viewModel.showMenu {
                Rectangle().opacity(0.3).ignoresSafeArea().onTapGesture { viewModel.showMenu.toggle() }
                HStack {
                    VStack(alignment: .leading, spacing: 13) {
                        SideMenuHeaderView()
                        List(Array(viewModel.models.enumerated()), id: \.element.id) { index, model in
                            if model.isHeader {
                                SideMenuHeaderCellView(position: index, model: model, action: { _index, _model in
                                    viewModel.onHeaderCellClick(position: _index, model: _model)
                                })
                            } else {
                                SideMenuCellView(model: model)
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(.white)
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: viewModel.showMenu)
    }
}

#Preview {
    SideMenuView(
        viewModel: ViewModel()
    )
}
