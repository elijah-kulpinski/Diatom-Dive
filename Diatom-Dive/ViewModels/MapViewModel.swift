//
//  MapViewModel.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 4/12/24.
//

import SwiftUI
import Foundation
import MapKit

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var diatomLocations: [DiatomLocation] = [
        DiatomLocation(name: "Sample Diatom 1", coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), notes: "Found in freshwater."),
        DiatomLocation(name: "Sample Diatom 2", coordinate: CLLocationCoordinate2D(latitude: 35.0522, longitude: -119.2437), notes: "Found near the coast.")
    ]
    @Published var selectedLocation: DiatomLocation?
    @Published var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            // Handle location services being disabled
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location.coordinate
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location error
    }
}

struct DiatomLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let notes: String
}
