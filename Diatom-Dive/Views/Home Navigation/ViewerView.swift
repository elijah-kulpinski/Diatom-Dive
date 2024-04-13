//
//  ViewerView.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 3/28/24.
//

import Foundation
import SwiftUI

struct ViewerView: View {
    @ObservedObject var viewModel = ViewerViewModel()
    @State private var showTaxonomyDetails = false
    @State private var searchText = ""

    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)

            VStack {
                // Navigation Bar with Search
                HStack {
                    NavigationBarView(searchText: $searchText, showingBookmarks: .constant(false), viewName: "Diatom Viewer") {
                        viewModel.searchDiatom(by: searchText)
                    }
                    
                    // Trigger search results dropdown menu adjacent to search bar
                    if viewModel.isSearchActive && !searchText.isEmpty {
                        Menu {
                            ForEach(viewModel.searchResults, id: \.self) { result in
                                Button(action: {
                                    viewModel.selectDiatom(from: viewModel.searchResults, at: viewModel.searchResults.firstIndex(of: result)!)
                                    searchText = "" // Clear search text after selection
                                    viewModel.isSearchActive = false // Close the dropdown
                                }) {
                                    Text(result.taxonomy.species)
                                        .foregroundColor(.black)
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing, 20) // Ensure the dropdown arrow is aligned to the right of the search bar
                    }
                }

                if let diatom = viewModel.diatom {
                    VStack {
                        Image(diatom.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: UIScreen.main.bounds.height / 2)

                        navigationControls

                        ScrollView {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(diatom.taxonomy.species)
                                    .font(.title2)
                                    .bold()
                                    .padding(.bottom, 5)

                                diatomDetails(diatom: diatom)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding()

                            databaseLinksSection
                        }
                    }
                } else {
                    Text("No diatom information available.")
                        .padding()
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    private var navigationControls: some View {
        HStack {
            Button(action: viewModel.previousDiatom) {
                Image(systemName: "arrow.left.circle.fill")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
            }
            Spacer()
            Button(action: viewModel.nextDiatom) {
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
            }
        }
        .padding()
    }

    private func diatomDetails(diatom: ViewerViewModel.Diatom) -> some View {
        VStack(alignment: .leading) {
            toggleableTaxonomySection(diatom: diatom)
            Text("Frustule Shape:").bold() + Text(" \(diatom.frustuleShape)")
            Text("Habitat:").bold() + Text(" \(diatom.habitat)")
            Text("Locations:").bold() + Text(" \(diatom.locations)")
            Text("Distinctive Features:").bold() + Text(" \(diatom.distinctiveFeatures)")
            Text("Ecological Significance:").bold() + Text(" \(diatom.ecologicalSignificance)")
        }
    }

    private func toggleableTaxonomySection(diatom: ViewerViewModel.Diatom) -> some View {
        VStack(alignment: .leading) {
            Button(action: { showTaxonomyDetails.toggle() }) {
                HStack {
                    Text("Taxonomy:").bold()
                    Image(systemName: showTaxonomyDetails ? "chevron.up" : "chevron.down")
                }
            }
            .buttonStyle(PlainButtonStyle())

            if showTaxonomyDetails {
                VStack(alignment: .leading) {
                    Text("\tKingdom:").bold() + Text(" \(diatom.taxonomy.kingdom)")
                    Text("\tPhylum:").bold() + Text(" \(diatom.taxonomy.phylum)")
                    Text("\tOrder:").bold() + Text(" \(diatom.taxonomy.order)")
                    Text("\tFamily:").bold() + Text(" \(diatom.taxonomy.family)")
                    Text("\tGenus:").bold() + Text(" \(diatom.taxonomy.genus)")
                    Text("\tSpecies:").bold() + Text(" \(diatom.taxonomy.species)")
                }
            }
        }
    }

    private var databaseLinksSection: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.databaseLinks, id: \.self) { link in
                        Text(link)
                            .padding(.horizontal, 10)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

struct ViewerView_Previews: PreviewProvider {
    static var previews: some View {
        ViewerView()
    }
}
