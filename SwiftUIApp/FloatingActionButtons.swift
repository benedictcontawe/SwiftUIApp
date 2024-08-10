//
//  FloatingActionButtons.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/10/24.
//

import SwiftUI

struct FloatingActionButtons: View {
    let lead : CGFloat
    let trail : CGFloat
    let bottom : CGFloat
    let addAction : () -> Void
    let clearAction : () -> Void
    var body: some View {
        Button(
            action: {
                addAction()
            }
        ) {
            Image(systemName: "plus")
                .resizable()
                .padding(.all, 3)
                .foregroundColor(.green)
                .background(Color.white)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .position(
            x: lead,
            y: bottom
        )
        
        Button(
            action: {
                clearAction()
            }
        ) {
            Image(systemName: "trash")
                .resizable()
                .padding(.all, 3)
                .foregroundColor(.orange)
                .background(Color.white)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .position(
            x: trail,
            y: bottom
        )
    }
}

#Preview {
    FloatingActionButtons(lead: 13, trail: 13, bottom:13, addAction: {}, clearAction: {})
}
