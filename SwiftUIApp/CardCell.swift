//
//  CardCell.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/15/24.
//

import SwiftUI

struct CardCell: View {
    let model: NasaHolderModel

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: model.image)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Image(systemName: "photo").foregroundStyle(.secondary)
            }
            .frame(width: 72, height: 72)
            .background(.quaternary)
            .clipShape(.rect(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(model.title)
                    .font(.headline)
                Text(model.date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(model.explanation)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                let copyright = model.copyright.trimmingCharacters(in: .whitespacesAndNewlines)
                if !copyright.isEmpty {
                    Text("© \(copyright)")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    CardCell(model: NasaHolderModel(response: NasaResponseModel(
        title: "Total Solar Eclipse", copyright: "Jane Astronomer", date: "2024-04-08",
        hdurl: nil, explanation: "The Moon passes between Earth and the Sun.")))
        .padding()
}
