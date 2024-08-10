//
//  CardCell.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/10/24.
//

import SwiftUI

struct CardCell : View {
    let index : Int
    let name : String
    let cellAction : () -> Void
    let editAction : () -> Void
    let deleteAction : () -> Void
    var body: some View {
        Button(
            action: {
                cellAction()
            },
            label:  {
                HStack(spacing: 3) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 50)
                    
                    Text(name)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack(spacing: 3) {
                        Button(
                            action: {
                                editAction()
                            },
                            label: {
                                Text("Edit")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        )

                        Button(
                            action: {
                                deleteAction()
                            },
                            label: {
                                Text("Delete")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        )
                    }
                }
                .padding(
                    EdgeInsets(
                        top: UIScreen.main.bounds.height * 0.01,
                        leading: UIScreen.main.bounds.width * 0.03,
                        bottom: UIScreen.main.bounds.height * 0.01,
                        trailing: UIScreen.main.bounds.width * 0.03
                    )
                )
                .background(Color(.systemGray5))
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            }
        )
    }
}

#Preview {
    CardCell(index: 0, name: "[ Name ]", cellAction: {},editAction: {}, deleteAction: {})
}
