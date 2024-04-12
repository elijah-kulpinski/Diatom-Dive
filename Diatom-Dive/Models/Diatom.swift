//
//  Diatom.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 4/11/24.
//

import Foundation

//TODO: Move hardcoded diatoms in Diatom.swift (Models Folder) to Firebase

struct Diatom: Identifiable, Codable {
    let id = UUID()
    let name: String
    let imageName: String
    let taxonomy: [String: String]
    let habitat: String
    let size: Double
    let region: String
    let discoveryDate: Date
}

let diatoms = [
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

