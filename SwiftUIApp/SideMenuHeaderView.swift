//
//  SideMenuHeaderView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/23/24.
//

import SwiftUI

struct SideMenuHeaderView : View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 6, content: {
                Text("Header")
                    .font(.subheadline)
                Text("Sub Header")
                    .font(.footnote)
                    .tint(.gray)
            })
        }
    }
}

#Preview {
    SideMenuHeaderView()
}
