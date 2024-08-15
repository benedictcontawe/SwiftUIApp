//
//  CardCell.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/15/24.
//

import SwiftUI

struct CardCell : View {
    let index : Int
    let image : String?
    let title : String?
    let explanation : String?
    let date : String?
    let copyright : String?
    var body: some View {
        Button(
            action: {/*cellAction()*/},
            label:  {
                HStack() {
                    AsyncImage(url: URL(string: image ?? "")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width * 0.2)
                        case .failure(_):
                            Image(systemName: "xmark.icloud.fill")
                                .foregroundColor(.red)
                                .opacity(0.6)
                        case .empty:
                            ProgressView().frame(width: UIScreen.main.bounds.width * 0.2)
                        @unknown default:
                            Image(systemName: "photo.fill.on.rectangle.fill")
                                .foregroundColor(.white)
                                .opacity(0.6)
                        }
                    }
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                        Text(title ?? "Nil")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text(explanation ?? "Nil")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }).frame(width: UIScreen.main.bounds.width * 0.6)
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                        Text(date ?? "Nil")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text(copyright ?? "Nil")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }).frame(width: UIScreen.main.bounds.width * 0.2)
                }
                .padding(
                    EdgeInsets(
                        top: UIScreen.main.bounds.height * 0.01,
                        leading: UIScreen.main.bounds.width * 0.01,
                        bottom: UIScreen.main.bounds.height * 0.01,
                        trailing: UIScreen.main.bounds.width * 0.01
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
    CardCell(index: 0, image: "Image Url",title: "[Title]", explanation: "[Explanation]", date: "[Date]", copyright: "[Copyright]")
}
