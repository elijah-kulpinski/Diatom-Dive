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
    @State private var trackingMode: MapUserTrackingMode = .follow

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $trackingMode,
                annotationItems: viewModel.diatomLocations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    Button(action: {
                        viewModel.selectedLocation = location
                    }) {
                        Image("SpotlightMarkerIcon")
                            .resizable()
                            .frame(width: 30, height: 50)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .blur(radius: 3.0)
            .onTapGesture {
                // Dismiss the detail view when tapping anywhere else on the map
                viewModel.selectedLocation = nil
            }

            if let selectedDiatom = viewModel.selectedLocation {
                MapDetailView(diatomLocation: selectedDiatom)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                    .transition(.slide)
                    .animation(.easeInOut, value: viewModel.selectedLocation)
                    .onTapGesture {
                        // Prevent the map's tap gesture from firing
                        // This ensures the details view doesn't dismiss when it's tapped
                    }
            }

            FogOfWarOverlay(viewModel: viewModel)
                .allowsHitTesting(false)
        }
        .onAppear {
            viewModel.checkIfLocationServicesIsEnabled()
        }
    }
}

struct FogOfWarOverlay: View {
    @ObservedObject var viewModel: MapViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Applying the custom color and blur
                Rectangle()
                    .fill(Color("FogOfWarColor"))
                    .opacity(0.75)
                    .blur(radius: 1)
                    .edgesIgnoringSafeArea(.all)

                // Mask for creating clear areas in the fog
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .mask(
                        FogClearPath(viewModel: viewModel, geometry: geometry)
                            .fill(style: FillStyle(eoFill: true))
                    )
            }
        }
    }
}

struct FogClearPath: Shape {
    let viewModel: MapViewModel
    var geometry: GeometryProxy

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(origin: .zero, size: geometry.size))

        // Using an instance of MKMapView to convert geographic coordinates to screen points
        let mapView = MKMapView(frame: CGRect(origin: .zero, size: geometry.size))
        for location in viewModel.clearedAreas {
            let point = mapView.convert(location.coordinate, toPointTo: mapView)
            path.addEllipse(in: CGRect(x: point.x - 50, y: point.y - 50, width: 100, height: 100))
        }
        
        return path
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
