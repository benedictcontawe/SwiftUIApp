//
//  CardCell.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/15/24.
//

import SwiftUI

struct CardCell: View {
    let picture: NasaResponseModel

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: picture.hdurl ?? "")) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Image(systemName: "photo").foregroundStyle(.secondary)
            }
            .frame(width: 72, height: 72)
            .background(.quaternary)
            .clipShape(.rect(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(picture.title ?? "")
                    .font(.headline)
                Text(picture.date ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(picture.explanation ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                if let copyright = picture.copyright {
                    Text("© \(copyright.trimmingCharacters(in: .whitespacesAndNewlines))")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    CardCell(picture: NasaResponseModel(title: "Total Solar Eclipse", copyright: "Jane Astronomer",
                                        date: "2024-04-08", hdurl: nil,
                                        explanation: "The Moon passes between Earth and the Sun."))
        .padding()
}
