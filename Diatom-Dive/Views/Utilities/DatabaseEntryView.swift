//
//  DatabaseEntryView.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 4/11/24.
//

import SwiftUI

struct DatabaseEntryView: View {
    var diatom: Diatom
    @ObservedObject var viewModel: DiatomDatabaseViewModel
    var action: () -> Void

    var body: some View {
        HStack {
            // Left Side: Bookmark and Diatom Image
            Button(action: {
                viewModel.toggleBookmark(for: diatom)
            }) {
                Image(systemName: viewModel.isBookmarked(diatom) ? "bookmark.fill" : "bookmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 30)
                    .foregroundColor(.black)
            }
            
            Image(diatom.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 30)  // Fixed width for image

            Spacer()  // Pushes everything to the edges

            // Right Side: Diatom Name and Learn More Button
            HStack {
                Text(diatom.name)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: 160)  // Limit the name width based on expected content
                    .padding(.leading, 10)

                Button(action: action) {
                    Text("Learn More")
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color("LearnMoreButtonColor"))
                        .cornerRadius(5)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
            }
            .frame(maxWidth: .infinity)  // Allows the right content to fill remaining space
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 5)
        .frame(height: 40)
        .background(Color("EntryBackgroundColor"))
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}
