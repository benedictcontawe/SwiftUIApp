//
//  SideMenuHeaderCellView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/24/24.
//

import SwiftUI

struct SideMenuHeaderCellView : View {
    let position : Int
    let model : DrawerModel
    let action : (Int, DrawerModel) -> Void
    var body: some View {
        Button(
            action: {
                action(position, model)
            },
            label: {
                HStack {
                    if model.isExpand {
                        Image(systemName: "arrow.up")
                            .imageScale(.small)
                    } else if model.isExpand == false  {
                        Image(systemName: "arrow.down")
                            .imageScale(.small)
                    }
                    Text(model.text)
                        .font(.subheadline)
                    //Text(model.isExpand.description)
                    Spacer()
                }
                .padding(.leading)
                .frame(height: 44)
            }
        )
    }
}

#Preview {
    SideMenuHeaderCellView(position: 0, model: DrawerModel(text: "Text", isHeader: false, isExpand: true, icon: nil)) { position, model in }
}
