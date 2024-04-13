//
//  StudyView.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 3/28/24.
//

import Foundation
import SwiftUI

struct StudyView: View {
    @StateObject var viewModel = StudyViewModel()  // StateObject to manage lifecycle correctly
    @State private var showingBookmarks = false

    // Padding Constants
    private let topNavBarPadding: CGFloat = 40
    private let gridSpacing: CGFloat = 20
    private let cardPadding: CGFloat = 20
    private let gridHorizontalPadding: CGFloat = 20
    private let gridTopPadding: CGFloat = 15

    var body: some View {
        ZStack {
            // Background image
            Image("StudyBackgroundImg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)  // Covers the whole screen

            // Main content arranged vertically
            VStack(spacing: 0) {
                // Navigation bar with adjusted top padding
                NavigationBarView(searchText: $viewModel.searchText, showingBookmarks: $showingBookmarks, viewName: "Study Materials", onCommit: {
                    viewModel.filterMaterials()
                })
                .padding(.top, topNavBarPadding)  // Use constant for top padding

                // Scrollable grid for cards
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: gridSpacing), GridItem(.flexible())], spacing: gridSpacing) {
                        CardView(imageName: "BiologyCard", labelText: "Biology")
                            .padding([.leading, .trailing], cardPadding)  // Use constant for padding
                        CardView(imageName: "EcologyCard", labelText: "Ecology")
                            .padding([.leading, .trailing], cardPadding)
                        CardView(imageName: "HistoryCard", labelText: "History")
                            .padding([.leading, .trailing], cardPadding)
                        CardView(imageName: "ResearchCard", labelText: "Research")
                            .padding([.leading, .trailing], cardPadding)
                        CardView(imageName: "DiscoveryCard", labelText: "Discovery")
                            .padding([.leading, .trailing], cardPadding)
                        CardView(imageName: "QuizCard", labelText: "Quiz")
                            .padding([.leading, .trailing], cardPadding)
                    }
                    .padding(.horizontal, gridHorizontalPadding)  // Use constant for horizontal padding
                    .padding(.top, gridTopPadding)  // Use constant for top padding under navigation bar
                }
                .frame(maxHeight: .infinity) // Ensures the scroll view takes up all available space
            }
        }
    }
}

struct StudyView_Previews: PreviewProvider {
    static var previews: some View {
        StudyView()
    }
}
