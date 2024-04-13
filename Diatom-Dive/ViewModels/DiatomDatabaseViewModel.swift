//
//  DiatomDatabaseViewModel.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 4/11/24.
//

import Combine
import Foundation
import SwiftUI
import UIKit

class DiatomDatabaseViewModel: ObservableObject {
    @Published var diatoms: [Diatom]
    @Published var sortedDiatoms: [Diatom] = []
    @Published var searchText: String = ""
    @Published var selectedHabitat: String?
    @Published var selectedRegion: String?
    @Published var selectedTaxonomyRank: String?
    //@Published var selectedTaxonomy: (rank: String, value: String)?
    @Published var isAscendingName: Bool = true
    @Published var isAscendingSize: Bool = true
    @Published var isAscendingDiscovery: Bool = true
    @Published var bookmarks: Set<UUID> = []
    
    let allHabitats: [String] = [
        "Freshwater Lakes",
        "Freshwater Rivers",
        "Freshwater Streams",
        "Marine Coastal Waters",
        "Marine Open Ocean",
        "Brackish Estuaries",
        "Brackish Mangroves",
        "Riverine Environments",
        "Estuarine Zones",
        "Oceanic Pelagic Zones",
        "Oceanic Benthic Zones",
        "Acidic Bogs",
        "Alkaline Lakes",
        "Hypersaline Lagoons",
        "Polar Ice Waters",
        "Thermal Hot Springs",
        "Geothermal Pools",
        "Subterranean Aquifers",
        "Benthic Sediments",
        "Pelagic Water Columns",
        "Terrestrial Mosses",
        "Damp Soil Areas",
        "Desert Crusts",
        "Artificial Reservoirs",
        "Agricultural Water Systems",
        "Urban Water Bodies",
        "Industrial Areas",
        "Temporary Puddles",
        "Intermittent Streams",
        "Cave Water Systems",
        "Volcanic Craters",
        "Salt Marshes",
        "Seagrass Meadows",
        "Coral Reefs",
        "Kelp Forests",
        "Mudflats",
        "Tidal Flats",
        "Wet Walls",
        "Roof Gutters",
        "Bird Baths"
    ]
    
    let allRegions: [String] = [
        "North America",
        "Central America",
        "South America",
        "Caribbean",
        "Northern Europe",
        "Southern Europe",
        "Western Europe",
        "Eastern Europe",
        "North Asia",
        "South Asia",
        "East Asia",
        "Southeast Asia",
        "Central Asia",
        "Middle East",
        "Northern Africa",
        "Sub-Saharan Africa",
        "East Africa",
        "West Africa",
        "South Africa",
        "Central Africa",
        "Australia",
        "New Zealand",
        "Pacific Islands",
        "Antarctic",
        "Arctic",
        "Atlantic Ocean",
        "Pacific Ocean",
        "Indian Ocean",
        "Arabian Peninsula",
        "Scandinavia",
        "Balkans",
        "Caucasus",
        "Siberia",
        "Indo-China",
        "Micronesia",
        "Polynesia",
        "Melanesia",
        "Mediterranean Basin",
        "The Himalayas",
        "The Alps",
        "The Andes",
        "The Rockies",
        "The Great Lakes",
        "The Amazon Basin",
        "The Congo Basin",
        "The Mississippi River Basin",
        "The Nile Basin",
        "The Ganges Basin",
        "The Danube Basin",
        "The Volga Basin"
    ]
    
    let taxonomyRanks: [TaxonomyRank] = [
        TaxonomyRank(rank: "Kingdom", values: ["Bacillariophyta"]),
        TaxonomyRank(rank: "Phylum", values: ["Bacillariophyceae", "Mediophyceae", "Coscinodiscophyceae"]),
        TaxonomyRank(rank: "Class", values: [
            "Bacillariophyceae", "Coscinodiscophyceae", "Fragilariophyceae", "Mediophyceae",
            "Eunotiophyceae", "Ulnariophyceae"
        ]),
        TaxonomyRank(rank: "Order", values: [
            "Naviculales", "Thalassiosirales", "Cymbellales", "Eunotiales", "Arachnoidiscales",
            "Aulacoseirales", "Bacillariales", "Biddulphiales", "Centrales", "Chaetocerotales",
            "Cocconeidales", "Cymatosirales", "Diatomales", "Ditylales", "Ethmodiscales",
            "Fragilariales", "Hemiaulales", "Lauderiales", "Lithodesmiales", "Mastogloiales",
            "Melosirales", "Meridianales", "Monoraphidales", "Orthoseirales", "Parlibellales",
            "Phaeodactylales", "Protoraphidales", "Rhizosoleniales", "Stephanodiscales",
            "Striatellales", "Surirellales", "Tabellariales", "Thalassionematales", "Toxariales",
            "Triceratiales", "Triceromonadales", "Trieresidales"
        ]),
        TaxonomyRank(rank: "Family", values: [
            "Naviculaceae", "Cymbellaceae", "Thalassiosiraceae", "Fragilariaceae", "Pinnulariaceae",
            "Achnanthaceae", "Amphipleuraceae", "Anomoeoneidaceae", "Asterionellaceae", "Aulacoseiraceae",
            "Bacillariaceae", "Biddulphiaceae", "Brachysiraceae", "Chaetocerotaceae", "Cocconeidaceae",
            "Coscinodiscaceae", "Craspedopodiaceae", "Cymatosiraceae", "Cymbellaceae", "Diadesmidaceae",
            "Diatomaceae", "Dictyoneidaceae", "Diploneidaceae", "Eunotiaceae", "Fragilariaceae",
            "Gomphonemataceae", "Grammatophoraceae", "Hemiaulaceae", "Himantoniaceae", "Lauderiaceae",
            "Leptocylindraceae", "Licmophoraceae", "Lithodesmiaceae", "Melosiraceae", "Meridianaceae",
            "Monoraphidaceae", "Nitzschiaceae", "Odontellaceae", "Parlibellaceae", "Phaeodactylaceae",
            "Plagiogrammaceae", "Pleurosigmataceae", "Protoraphidaceae", "Pseudonaviculaceae",
            "Rhopalodiaceae", "Rhizosoleniaceae", "Stauroneidaceae", "Stephanodiscaceae", "Surirellaceae",
            "Tabellariaceae", "Terpsinoaceae", "Thalassiosiraceae", "Toxariaceae", "Triceratiaceae",
            "Triceromonadaceae", "Trieresiaceae"
        ]),
        TaxonomyRank(rank: "Genus", values: [
            "Navicula", "Cymbella", "Thalassiosira", "Pinnularia", "Fragilaria", "Achnanthes", "Asterionella",
            "Bacillaria", "Biddulphia", "Chaetoceros", "Cocconeis", "Coscinodiscus", "Cyclotella",
            "Diploneis", "Eunotia", "Gomphonema", "Hantzschia", "Melosira", "Meridion", "Nitzschia",
            "Odontella", "Parlibellus", "Phaeodactylum", "Pleurosigma", "Pseudonavicula", "Rhopalodia",
            "Stauroneis", "Stephanodiscus", "Surirella", "Tabellaria", "Trieres", "Triceratium"
        ]),
        TaxonomyRank(rank: "Species", values: [
            "Navicula cryptocephala", "Cymbella cistula", "Thalassiosira pseudonana", "Pinnularia major",
            "Fragilaria crotonensis", "Achnanthes minutissima", "Asterionella formosa", "Bacillaria paxillifer",
            "Biddulphia sinensis", "Chaetoceros muelleri", "Cocconeis placentula", "Coscinodiscus granii",
            "Cyclotella meneghiniana", "Diploneis ovalis", "Eunotia diadema", "Gomphonema parvulum",
            "Hantzschia amphioxys", "Melosira varians", "Meridion circulare", "Nitzschia palea",
            "Odontella aurita", "Parlibellus delognei", "Phaeodactylum tricornutum", "Pleurosigma angulatum",
            "Pseudonavicula pusilla", "Rhopalodia gibberula", "Stauroneis phoenicenteron", "Stephanodiscus hantzschii",
            "Surirella brebissonii", "Tabellaria flocculosa", "Trieres chinensis", "Triceratium favus"
        ])
    ]
    
    init() {
        diatoms = [
            Diatom(name: "Pinnularia", imageName: "PinnulariaProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Freshwater Rivers", size: 0.02, region: "North America", discoveryDate: Date()),
            Diatom(name: "Triceratium", imageName: "TriceratiumProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Marine Coastal Waters", size: 0.05, region: "Pacific Islands", discoveryDate: Date()),
            Diatom(name: "Asteroniella", imageName: "AsteroniellaProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Brackish Estuaries", size: 0.01, region: "Atlantic Ocean", discoveryDate: Date()),
            Diatom(name: "Stauroneus", imageName: "StauroneusProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Riverine Environments", size: 0.03, region: "Western Europe", discoveryDate: Date()),
            Diatom(name: "Melosira", imageName: "MelosiraProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Freshwater Lakes", size: 0.04, region: "North America", discoveryDate: Date()),
            Diatom(name: "Cylindrotheca", imageName: "CylindrothecaProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Estuarine Zones", size: 0.02, region: "Southeast Asia", discoveryDate: Date()),
            Diatom(name: "Centric", imageName: "CentricProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Oceanic Pelagic Zones", size: 0.1, region: "Global Oceans", discoveryDate: Date()),
            Diatom(name: "Coscinosdiscus", imageName: "CoscinosdiscusProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Marine Open Ocean", size: 0.15, region: "Global Oceans", discoveryDate: Date()),
            Diatom(name: "Diploneis", imageName: "DiploneisProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Estuarine Zones", size: 0.05, region: "Australia", discoveryDate: Date()),
            Diatom(name: "Tabellaria", imageName: "TabellariaProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Freshwater Streams", size: 0.03, region: "Northern Europe", discoveryDate: Date()),
            Diatom(name: "Bacillaria", imageName: "BacillariaProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Freshwater Rivers", size: 0.04, region: "North America", discoveryDate: Date()),
            Diatom(name: "Surirella", imageName: "SurirellaProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Freshwater Lakes", size: 0.06, region: "South America", discoveryDate: Date()),
            Diatom(name: "Gomphonema", imageName: "GomphonemaProfileImg", taxonomy: ["Kingdom": "Bacillariophyta", "Phylum": "Bacillariophyceae"], habitat: "Terrestrial Mosses", size: 0.02, region: "East Asia", discoveryDate: Date())
        ]
        updateSortedDiatoms()
    }
    
    var activeFilters: [String] {
        var filters = [String]()
        if let habitat = selectedHabitat {
            filters.append("Habitat: \(habitat)")
        }
        if let region = selectedRegion {
            filters.append("Region: \(region)")
        }
        if let taxonomy = selectedTaxonomyRank {
            //filters.append("Taxonomy: \(taxonomy.rank) - \(taxonomy.value)")
        }
        return filters
    }
    
    func updateSortedDiatoms() {
        sortedDiatoms = diatoms.filter { diatom in
            (selectedHabitat == nil || diatom.habitat == selectedHabitat) &&
            (selectedRegion == nil || diatom.region == selectedRegion) &&
            (selectedTaxonomyRank == nil)
        }
    }

    func setTaxonomyRank(rank: String) {
        selectedTaxonomyRank = rank
        updateSortedDiatoms()
    }
    
//    func setTaxonomyRank(rank: String, value: String) {
//        selectedTaxonomy = (rank, value)
//        updateSortedDiatoms()
//    }

    func clearFilters() {
        selectedHabitat = nil
        selectedRegion = nil
        selectedTaxonomyRank = nil
        //selectedTaxonomy = nil
        updateSortedDiatoms()
    }

    func setFilter(habitat: String? = nil, region: String? = nil, taxonomyRank: String? = nil) {
        selectedHabitat = habitat
        selectedRegion = region
        selectedTaxonomyRank = taxonomyRank
        updateSortedDiatoms()
    }
    
//    func setFilter(habitat: String? = nil, region: String? = nil, taxonomyRank: String? = nil, taxonomyValue: String? = nil) {
//        selectedHabitat = habitat
//        selectedRegion = region
//        if let rank = taxonomyRank, let value = taxonomyValue {
//            selectedTaxonomy = (rank, value)
//        } else {
//            selectedTaxonomy = nil
//        }
//        updateSortedDiatoms()
//    }
    
//    func filterDiatoms() {
//        print("Filtering diatoms with search text: '\(searchText)'")
//        if searchText.isEmpty {
//            updateSortedDiatoms()
//        } else {
//            sortedDiatoms = diatoms.filter { diatom in
//                diatom.name.lowercased().contains(searchText.lowercased()) ||
//                diatom.taxonomy.values.contains(where: { $0.lowercased().contains(searchText.lowercased()) }) ||
//                diatom.habitat.lowercased().contains(searchText.lowercased()) ||
//                diatom.region.lowercased().contains(searchText.lowercased())
//            }
//        }
//    }
    
    func filterDiatoms() {
        print("Filtering diatoms with search text: '\(searchText)'")
        if searchText.isEmpty {
            updateSortedDiatoms()
        } else {
            sortedDiatoms = diatoms.filter { diatom in
                // Start by checking if the diatom name starts with the searchText
                diatom.name.lowercased().starts(with: searchText.lowercased())
            }
        }
    }
    
    func removeFilter(_ filter: String) {
        // Determine which filter to remove based on the string
        if filter.starts(with: "Habitat:") {
            selectedHabitat = nil
        } else if filter.starts(with: "Region:") {
            selectedRegion = nil
        } else if filter.contains("Taxonomy:") {
            selectedTaxonomyRank = nil
        }
        updateSortedDiatoms()
    }

    func clearAllFilters() {
        selectedHabitat = nil
        selectedRegion = nil
        selectedTaxonomyRank = nil
        updateSortedDiatoms()
    }
    
    func sortDiatoms(ascending: Bool) {
        sortedDiatoms.sort { ascending ? $0.size < $1.size : $0.size > $1.size }
    }
    
    func sortByDiscoveryDate(ascending: Bool) {
        sortedDiatoms.sort { ascending ? $0.discoveryDate < $1.discoveryDate : $0.discoveryDate > $1.discoveryDate }
    }
    
    func toggleNameSorting() {
        isAscendingName.toggle()
        sortedDiatoms.sort { isAscendingName ? $0.name < $1.name : $0.name > $1.name }
    }
    
    func toggleSizeSorting() {
        isAscendingSize.toggle()
        sortedDiatoms.sort { isAscendingSize ? $0.size < $1.size : $0.size > $1.size }
    }
    
    func toggleDiscoveryDateSorting() {
        isAscendingDiscovery.toggle()
        sortedDiatoms.sort { isAscendingDiscovery ? $0.discoveryDate < $1.discoveryDate : $0.discoveryDate > $1.discoveryDate }
    }
    
    func setHabitatFilter(habitat: String) {
        selectedHabitat = habitat
        updateSortedDiatoms()
    }
    
    func setRegionFilter(region: String) {
        selectedRegion = region
        updateSortedDiatoms()
    }
    
    func downloadDataset() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601 // Use ISO 8601 format for dates
        encoder.outputFormatting = .prettyPrinted // Makes the JSON output easier to read
        
        do {
            let data = try encoder.encode(diatoms)
            let jsonString = String(data: data, encoding: .utf8) ?? "Unable to encode dataset to JSON"
            print(jsonString) // For debugging purposes; replace this with actual file saving logic
            saveToFile(data: data)
        } catch {
            print("Error encoding JSON: \(error)")
        }
    }
    
    func prepareDataForExport() -> Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(diatoms)
            return data
        } catch {
            print("Error encoding data: \(error)")
            return nil
        }
    }
    
    private func saveToFile(data: Data) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "diatom_dataset.json"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL, options: [.atomicWrite])
            print("Dataset saved to: \(fileURL)")
        } catch {
            print("Error saving file: \(error)")
        }
    }
    
    func toggleBookmark(for diatom: Diatom) {
        if bookmarks.contains(diatom.id) {
            bookmarks.remove(diatom.id)
        } else {
            bookmarks.insert(diatom.id)
        }
    }

    func isBookmarked(_ diatom: Diatom) -> Bool {
        bookmarks.contains(diatom.id)
    }

    var bookmarkedDiatoms: [Diatom] {
        diatoms.filter { bookmarks.contains($0.id) }
    }
}

struct TaxonomyRank {
    var rank: String
    var values: [String]
}

struct DocumentSaver: UIViewControllerRepresentable {
    var data: Data
    var completionHandler: ((URL?) -> Void)?
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let temporaryDirectoryURL = FileManager.default.temporaryDirectory.appendingPathComponent("diatom_dataset.json")
        do {
            try data.write(to: temporaryDirectoryURL)
        } catch {
            print("Could not write to temporary file: \(error)")
        }
        
        let controller = UIDocumentPickerViewController(forExporting: [temporaryDirectoryURL])
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        // No need to update the view controller in this use case.
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentSaver

        init(_ documentSaver: DocumentSaver) {
            self.parent = documentSaver
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            // Handle the file saving or use the URL
            parent.completionHandler?(urls.first)
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.completionHandler?(nil)
        }
    }
}


