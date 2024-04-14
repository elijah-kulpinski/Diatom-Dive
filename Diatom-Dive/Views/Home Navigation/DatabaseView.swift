//
//  DatabaseView.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 3/28/24.
//

import SwiftUI

struct DatabaseView: View {
    @ObservedObject var viewModel = DatabaseViewModel()
    @State private var showingBookmarks = false

    var body: some View {
        VStack {
            NavigationBarView(searchText: $viewModel.searchText, showingBookmarks: $showingBookmarks, viewName: "Database", onCommit: {
                viewModel.filterDiatoms()
            })
            SortingFilteringOptionsView(viewModel: viewModel)
            ActiveFiltersView(viewModel: viewModel)
            DiatomsListView(viewModel: viewModel, showingBookmarks: showingBookmarks)
            DownloadButtonView(viewModel: viewModel)
        }
        .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
    }
}

struct SortingFilteringOptionsView: View {
    @ObservedObject var viewModel: DatabaseViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                SortButton(label: "A-Z", isAscending: viewModel.isAscendingName, action: viewModel.toggleNameSorting)
                
                // Dynamic FilterMenu for Taxonomy using ranks from the model
                Menu("Taxonomy") {
                    ForEach(viewModel.taxonomyRanks.map { $0.rank }, id: \.self) { rank in
                        Button(rank) {
                            // Example action: set rank - this should ideally trigger another selection for values
                        }
                    }
                }
                
                // Dynamic FilterMenu for Habitat using habitats from the model
                Menu("Habitat") {
                    ForEach(viewModel.allHabitats, id: \.self) { habitat in
                        Button(habitat) {
                            viewModel.setHabitatFilter(habitat: habitat)
                        }
                    }
                }
                
                // Dynamic FilterMenu for Region using regions from the model
                Menu("Region") {
                    ForEach(viewModel.allRegions, id: \.self) { region in
                        Button(region) {
                            viewModel.setRegionFilter(region: region)
                        }
                    }
                }
                
                SortButton(label: "Size", isAscending: viewModel.isAscendingSize, action: viewModel.toggleSizeSorting)
                SortButton(label: "Discovery Date", isAscending: viewModel.isAscendingDiscovery, action: viewModel.toggleDiscoveryDateSorting)
            }
            .foregroundColor(.black)
            .padding(.horizontal)
        }
    }
}

struct SortButton: View {
    var label: String
    var isAscending: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
            Image(systemName: isAscending ? "arrow.up" : "arrow.down")
        }
        .foregroundColor(.black)
    }
}

struct FilterMenu: View {
    var title: String
    var options: [String]
    var action: (String) -> Void
    
    var body: some View {
        Menu(title) {
            ForEach(options, id: \.self) { option in
                Button(option) { action(option) }
            }
        }
        .foregroundColor(.black)
    }
}

struct ActiveFiltersView: View {
    @ObservedObject var viewModel: DatabaseViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.activeFilters, id: \.self) { filter in
                    HStack(spacing: 10) {
                        Text(filter)
                            .padding(.vertical, 5)
                            .padding(.leading, 10)
                        
                        Button(action: {
                            viewModel.removeFilter(filter)
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                                .opacity(0.9)
                                .padding(.trailing, 10)
                        }
                    }
                    .background(Color.white.opacity(0.6))  // Sets the background to wrap the entire content of HStack
                    .cornerRadius(15)
                    .transition(.scale)
                }
                if !viewModel.activeFilters.isEmpty {
                    Button("Clear Filters") {
                        viewModel.clearAllFilters()
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                }
            }
            .padding(.horizontal, 10)
        }
        .frame(height: 30) // Low height as requested
    }
}


struct DiatomsListView: View {
    @ObservedObject var viewModel: DatabaseViewModel
    var showingBookmarks: Bool
    
    var body: some View {
        List(showingBookmarks ? viewModel.bookmarkedDiatoms : viewModel.sortedDiatoms) { diatom in
            DatabaseEntryView(diatom: diatom, viewModel: viewModel, action: {
                print("Navigate to ViewerView for \(diatom.name)")
            })
            .listRowBackground(Color("BackgroundColor"))
        }
        .listStyle(PlainListStyle())
    }
}

struct DownloadButtonView: View {
    @ObservedObject var viewModel: DatabaseViewModel
    @State private var showDocumentPicker = false
    @State private var documentData: Data?
    
    var body: some View {
        Button("Download Dataset") {
            if let data = viewModel.prepareDataForExport() {
                documentData = data
                showDocumentPicker = true
            }
        }
        .padding()
        .background(Color("DownloadButtonColor"))
        .foregroundColor(.black)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
        .shadow(radius: 2, x: 0, y: 2)
        .sheet(isPresented: $showDocumentPicker) {
            if let data = documentData {
                DocumentSaver(data: data) { url in
                    // Handle post-save actions here if needed
                    print("Document saved at: \(url?.absoluteString ?? "Unknown location")")
                }
            }
        }
    }
}

struct DatabaseView_Previews: PreviewProvider {
    static var previews: some View {
        DatabaseView()
            .preferredColorScheme(.light)
            .previewDisplayName("Diatom Database Preview")
    }
}
