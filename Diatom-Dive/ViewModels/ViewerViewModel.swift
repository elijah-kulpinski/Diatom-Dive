//
//  ViewerViewModel.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 4/12/24.
//

import Foundation
import SwiftUI

extension ViewerViewModel {
    struct Diatom: Hashable {
        var imageName: String
        var taxonomy: Taxonomy
        var frustuleShape: String
        var habitat: String
        var locations: String
        var distinctiveFeatures: String
        var ecologicalSignificance: String
        
        // Struct for Taxonomy
        struct Taxonomy: Hashable {
            var kingdom: String
            var phylum: String
            var order: String
            var family: String
            var genus: String
            var species: String
        }
        
        // Example diatoms hardcoded with detailed taxonomy
        static let examples = [
            Diatom(imageName: "TriceratiumView",
                   taxonomy: Taxonomy(kingdom: "Protista", phylum: "Bacillariophyta", order: "Triceratiales", family: "Triceratiaceae", genus: "Triceratium", species: "Triceratium favus"),
                   frustuleShape: "Triangular",
                   habitat: "Marine environments",
                   locations: "Global oceans",
                   distinctiveFeatures: "Distinctive triangular frustule",
                   ecologicalSignificance: "Plays a role in marine food webs"),
            Diatom(imageName: "PinnulariaView",
                   taxonomy: Taxonomy(kingdom: "Protista", phylum: "Bacillariophyta", order: "Naviculales", family: "Pinnulariaceae", genus: "Pinnularia", species: "Pinnularia major"),
                   frustuleShape: "Linear",
                   habitat: "Freshwater streams",
                   locations: "North America",
                   distinctiveFeatures: "Long, narrow shape with fine striations",
                   ecologicalSignificance: "Contributes to silicon cycling"),
            Diatom(imageName: "AsteroniellaView",
                   taxonomy: Taxonomy(kingdom: "Protista", phylum: "Bacillariophyta", order: "Bacillariales", family: "Asterionellaceae", genus: "Asterionella", species: "Asterionella formosa"),
                   frustuleShape: "Elliptical",
                   habitat: "Freshwater",
                   locations: "Worldwide",
                   distinctiveFeatures: "Small size and unique banding",
                   ecologicalSignificance: "Important in nutrient cycling")
        ]
    }
}

class ViewerViewModel: ObservableObject {
    @Published var diatoms: [Diatom]
    @Published var diatom: Diatom?
    @Published var currentIndex: Int = 0
    @Published var databaseLinks: [String]
    @Published var searchResults: [Diatom] = []
    @Published var isSearchActive: Bool = false

    init() {
        self.diatoms = Diatom.examples
        self.databaseLinks = ["Diatom Dive", "Diatoms of North America", "AlgaeBase"]
        self.diatom = diatoms.isEmpty ? nil : diatoms[currentIndex]
    }

    func nextDiatom() {
        if diatoms.isEmpty { return }
        currentIndex = (currentIndex + 1) % diatoms.count
        diatom = diatoms[currentIndex]
    }

    func previousDiatom() {
        if diatoms.isEmpty { return }
        currentIndex = (currentIndex - 1 + diatoms.count) % diatoms.count
        diatom = diatoms[currentIndex]
    }

    func searchDiatom(by query: String) {
        searchResults = diatoms.filter { diatom in
            diatom.taxonomy.species.lowercased().contains(query.lowercased()) ||
            diatom.taxonomy.genus.lowercased().contains(query.lowercased())
        }
        isSearchActive = !searchResults.isEmpty
    }

    func selectDiatom(from results: [Diatom], at index: Int) {
        guard index >= 0 && index < results.count else { return }
        let result = results[index]
        if let foundIndex = diatoms.firstIndex(where: { $0.imageName == result.imageName }) {
            currentIndex = foundIndex
            diatom = diatoms[currentIndex]
        }
    }
}
