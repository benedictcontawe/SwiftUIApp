//
//  SideMenuCellView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/23/24.
//

import SwiftUI

struct SideMenuCellView : View {
    let model : DrawerModel
    var body: some View {
        if model.isExpand {
            Button (
                action: {
                    
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
    SideMenuCellView(model: DrawerModel(text: "Text", isHeader: false, isExpand: true, icon: nil))
}
