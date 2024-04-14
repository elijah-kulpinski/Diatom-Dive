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
    @Published var userLocation: EquatableCoordinate = EquatableCoordinate(coordinate: CLLocationCoordinate2D())
    @Published var clearedAreas: [EquatableCoordinate] = []
    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
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
             let newLocation = EquatableCoordinate(coordinate: location.coordinate)
             userLocation = newLocation
             if !clearedAreas.contains(newLocation) {
                 clearedAreas.append(newLocation)
             }
         }
     }

     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("Failed to find user's location: \(error.localizedDescription)")
     }
    
    // Function to clear an area of fog of war
    func clearArea(at coordinate: CLLocationCoordinate2D) {
        let equatableCoordinate = EquatableCoordinate(coordinate: coordinate)
        clearedAreas.append(equatableCoordinate)
    }
 }

 struct EquatableCoordinate: Equatable {
     var coordinate: CLLocationCoordinate2D

     static func == (lhs: EquatableCoordinate, rhs: EquatableCoordinate) -> Bool {
         return lhs.coordinate.latitude == rhs.coordinate.latitude &&
                lhs.coordinate.longitude == rhs.coordinate.longitude
     }
 }

struct DiatomLocation: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let notes: String

    static func == (lhs: DiatomLocation, rhs: DiatomLocation) -> Bool {
        return lhs.id == rhs.id
    }
}

