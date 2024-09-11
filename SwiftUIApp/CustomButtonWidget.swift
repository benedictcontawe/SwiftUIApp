//
//  ButtonWidget.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/11/24.
//

import SwiftUI

struct CustomButtonWidget: View {
    let text: String
    let onPressed: () -> Void
    var body: some View {
      Button(action: onPressed) {
        Text(text)
          .padding()
          .foregroundColor(.white)
          .background(Color.blue)
          .cornerRadius(10)
      }
    }
}

#Preview {
    CustomButtonWidget(text: "", onPressed: {})
}
