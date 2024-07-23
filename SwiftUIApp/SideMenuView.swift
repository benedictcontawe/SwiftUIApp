//
//  SideMenuView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/23/24.
//

import SwiftUI

struct SideMenuView : View {
    @Binding var isShowing : Bool
    @Binding var models : [DrawerModel]

    var body: some View {
        ZStack {
            if isShowing {
                Rectangle().opacity(0.3).ignoresSafeArea().onTapGesture { isShowing.toggle() }
                HStack {
                    VStack(alignment: .leading, spacing: 32) {
                        SideMenuHeaderView()
                        List(models) { model in
                            SideMenuCellView(model: model)
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
        .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
    SideMenuView(
        isShowing: .constant(true),
        models: .constant([
            DrawerModel(text: "AAA", isHeader: true, isExpand: true, icon: nil),
            DrawerModel(text: "BBB", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "CCC", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "DDD", isHeader: true, isExpand: true, icon: nil),
            DrawerModel(text: "EEE", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "FFF", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "GGG", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "HHH", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "III", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "JJJ", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "KKK", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "LLL", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "MMM", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "NNN", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "OOO", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "PPP", isHeader: false, isExpand: true, icon: nil)
        ])
    )
}
