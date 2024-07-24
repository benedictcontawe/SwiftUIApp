//
//  SideMenuHeaderCellView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/24/24.
//

import SwiftUI

struct SideMenuHeaderCellView : View {
    let model : DrawerModel
    var body: some View {
        Button(
            action: {
                //viewModel.onHeaderCellClick(position: <#T##Int#>, model: model)
            }, label: {
                HStack {
                    if model.isExpand {
                        Image(systemName: "arrow.up")
                            .imageScale(.small)
                    } else {
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
    SideMenuHeaderCellView(model: DrawerModel(text: "Text", isHeader: false, isExpand: true, icon: nil))
}
