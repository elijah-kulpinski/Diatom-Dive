//
//  MapView.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 3/28/24.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewModel = MapViewModel()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var trackingMode: MapUserTrackingMode = .follow  // State for tracking mode

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $trackingMode,
                annotationItems: viewModel.diatomLocations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    Image("SpotlightMarkerIcon")
                        .resizable()
                        .frame(width: 30, height: 50)
                }
            }
            .edgesIgnoringSafeArea(.all)

            // Fog of war overlay
            FogOfWarOverlay(userLocation: viewModel.userLocation)
        }
        .onAppear {
            viewModel.checkIfLocationServicesIsEnabled()
        }
    }
}

struct FogOfWarOverlay: View {
    var userLocation: CLLocationCoordinate2D
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background with blur and semi-transparency
                Color.gray//.opacity(0.9)
                    .blur(radius: 100)
                
                // Clear circle over the user's location
                // Calculate position based on map coordinates translated to view coordinates
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2) // Placeholder for center calculation
                Circle()
                    .fill(Color.clear)
                    .frame(width: 50, height: 50) // Circle size
                    .position(center)
            }
        }
    }
}

struct MapDetailView: View {
    var diatomLocation: DiatomLocation

    var body: some View {
        VStack {
            Text("Diatom Details")
            Text("Name: \(diatomLocation.name)")
            Text("Coordinates: \(diatomLocation.coordinate.latitude), \(diatomLocation.coordinate.longitude)")
            Text("Notes: \(diatomLocation.notes)")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
