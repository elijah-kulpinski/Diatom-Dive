//
//  StudyViewModel.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 4/12/24.
//

import Foundation
import Combine
import SwiftUI

class StudyViewModel: ObservableObject {
    @Published var materials: [StudyMaterial] = []
    @Published var filteredMaterials: [StudyMaterial] = []
    @Published var searchText: String = ""

    init() {
        loadInitialData()
    }

    private func loadInitialData() {
        materials = [
            StudyMaterial(title: "Introduction to Diatoms", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
            StudyMaterial(title: "Diatom Taxonomy", content: "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
            StudyMaterial(title: "Ecology of Diatoms", content: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip."),
            StudyMaterial(title: "Diatoms in Freshwater", content: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
        ]
        filteredMaterials = materials // Initialize with all materials
    }

    func filterMaterials() {
        if searchText.isEmpty {
            filteredMaterials = materials
        } else {
            filteredMaterials = materials.filter { material in
                material.title.lowercased().contains(searchText.lowercased()) ||
                material.content.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

// Define the StudyMaterial struct
struct StudyMaterial: Identifiable {
    var id: UUID = UUID() // Unique identifier for each study material
    var title: String // Title of the study material
    var content: String // Content or description of the study material
}
