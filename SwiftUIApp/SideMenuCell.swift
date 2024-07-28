//
//  SideMenuCellView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/23/24.
//

import SwiftUI

struct SideMenuCell : View {
    let model : DrawerModel
    let action : (String) -> Void
    var body: some View {
        if model.isExpand {
            Button (
                action: {
                    action(model.text)
                }, label: {
                    HStack {
                        Image(systemName: "paperplane")
                            .imageScale(.small)
                        Text(model.text)
                            .font(.subheadline)
                        Text(model.isExpand.description)
                        Spacer()
                    }
                    .padding(.leading)
                    .frame(height: 44)
                }
            )
        }
    }
}

#Preview {
    SideMenuCell(model: DrawerModel(text: "Text", isHeader: false, isExpand: true, icon: nil), action: { text in })
}
