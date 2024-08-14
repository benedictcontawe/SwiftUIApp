//
//  SideMenuView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/23/24.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var viewModel : ViewModel
    @GestureState private var dragOffset: CGSize = CGSize.zero
    var body: some View {
        ZStack {
            if viewModel.showMenu {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            viewModel.showMenu.toggle()
                        }
                    }
                HStack {
                    VStack(alignment: .leading, spacing: 32) {
                        SideMenuHeaderView()
                        List(Array(viewModel.models.enumerated()), id: \.element.id) { index, model in
                            if model.isHeader {
                                SideMenuHeaderCell(
                                    position: index,
                                    model: viewModel.models[index],
                                    action: { _index, _model in
                                        viewModel.onHeaderCellClick(position: _index, model: _model)
                                    }
                                )
                            } else {
                                SideMenuCell(
                                    model: model,
                                    action: { text in
                                        viewModel.selectedPage = text
                                        viewModel.showMenu = false
                                    }
                                )
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(Color.white)
                    .offset(x: dragOffset.width > 0 ? 0 : dragOffset.width)
                    .gesture(
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation
                            }
                            .onEnded { value in
                                if value.translation.width < -100 {
                                    withAnimation {
                                        viewModel.showMenu = false
                                    }
                                }
                            }
                    )
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: viewModel.showMenu)
    }
}

#Preview {
    SideMenuView()
}
