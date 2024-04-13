//
//  ResourcesView.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 3/28/24.
//

import Foundation
import SwiftUI

struct ResourcesView: View {
    @ObservedObject var viewModel = ResourcesViewModel()
    @State private var showingBookmarks = false

    // Padding Constants
    private let topNavBarPadding: CGFloat = 40
    private let gridSpacing: CGFloat = 20
    private let cardPadding: CGFloat = 20
    private let gridHorizontalPadding: CGFloat = 20
    private let gridTopPadding: CGFloat = 15

    var body: some View {
        ZStack {
            // Resources background
            Image("ResourcesBackgroundImg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)  // Cover the entire screen without specific offsets

            // Main content arranged vertically
            VStack(spacing: 0) {
                // Navigation bar with adjusted top padding
                NavigationBarView(searchText: $viewModel.searchText, showingBookmarks: $showingBookmarks, viewName: "Resources", onCommit: {
                    viewModel.filterResources()
                })
                .padding(.top, topNavBarPadding)  // Use constant for top padding

                // Scrollable grid for cards
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: gridSpacing), GridItem(.flexible())], spacing: gridSpacing) {
                        CardView(imageName: "AppsCard", labelText: "Apps")
                            .padding([.leading, .trailing], cardPadding)
                        CardView(imageName: "ArticlesCard", labelText: "Articles")
                            .padding([.leading, .trailing], cardPadding)
                        CardView(imageName: "GlossaryCard", labelText: "Glossary")
                            .padding([.leading, .trailing], cardPadding)
                        CardView(imageName: "PapersCard", labelText: "Papers")
                            .padding([.leading, .trailing], cardPadding)
                        CardView(imageName: "ReferencesCard", labelText: "References")
                            .padding([.leading, .trailing], cardPadding)
                        CardView(imageName: "VideosCard", labelText: "Videos")
                            .padding([.leading, .trailing], cardPadding)
                    }
                    .padding(.horizontal, gridHorizontalPadding)  // Use constant for horizontal padding
                    .padding(.top, gridTopPadding)                // Use constant for top padding under navigation bar
                }
                .frame(maxHeight: .infinity) // Ensures the scroll view takes up all available space
            }
        }
    }
}

struct ResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcesView()
    }
}


