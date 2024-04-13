//
//  ResourcesViewModel.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 4/12/24.
//

import Foundation
import Combine
import SwiftUI

class ResourcesViewModel: ObservableObject {
    @Published var resources: [ResourceMaterial] = []
    @Published var filteredResources: [ResourceMaterial] = []
    @Published var searchText: String = ""

    init() {
        loadInitialData()
    }

    private func loadInitialData() {
        resources = [
            ResourceMaterial(title: "Conservation of Diatoms", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
            ResourceMaterial(title: "Diatom Habitat Studies", content: "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
            ResourceMaterial(title: "Techniques in Diatom Analysis", content: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip."),
            ResourceMaterial(title: "Advanced Diatom Taxonomy", content: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
        ]
        filteredResources = resources // Start with all materials visible
    }

    func filterResources() {
        if searchText.isEmpty {
            filteredResources = resources
        } else {
            filteredResources = resources.filter { resource in
                resource.title.lowercased().contains(searchText.lowercased()) ||
                resource.content.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

// Define the ResourceMaterial struct
struct ResourceMaterial: Identifiable {
    var id: UUID = UUID() // Unique identifier for each resource material
    var title: String // Title of the resource material
    var content: String // Detailed content or description of the resource material
}
