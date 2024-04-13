import Foundation
import SwiftUI
import CoreLocation

struct DiatomUpload: Codable {
    var name: String
    var location: String
    var frustuleShape: String
    var dateTime: Date
    var habitatType: String
    var waterBodyType: String
    var imageDescription: String
    var notes: String
}

extension UploadViewModel {
    // Function to filter species based on user input
    func filteredSpecies(query: String) -> [String] {
        if query.isEmpty {
            return knownSpecies
        }
        return knownSpecies.filter { $0.lowercased().contains(query.lowercased()) }
    }
}

struct SpeciesPicker: View {
    @Binding var species: String
    @ObservedObject var viewModel: UploadViewModel  // Using ViewModel directly
    @State private var searchText = ""

    var body: some View {
        VStack {
            TextField("Start typing species name...", text: $searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .onChange(of: searchText){
                    viewModel.filterSpecies(query: searchText)
                }

            if viewModel.isSearchActive {
                List(viewModel.filteredSpecies, id: \.self) { species in
                    Text(species).onTapGesture {
                        self.species = species
                        viewModel.isSearchActive = false  // Hide list after selection
                    }
                }
            }
        }
    }
}


class UploadViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var diatomUpload: DiatomUpload = DiatomUpload(name: "", location: "", frustuleShape: "", dateTime: Date(), habitatType: "", waterBodyType: "", imageDescription: "", notes: "")
    @Published var image: Image?
    @Published var isShowingErrorAlert = false
    @Published var errorMessage = ""
    @Published var locationManager = CLLocationManager()
    @Published var knownSpecies = ["Asterionella formosa", "Pinnularia major", "Triceratium favus"]
    @Published var filteredSpecies: [String] = []
    @Published var isSearchActive = false

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func filterSpecies(query: String) {
        if query.isEmpty {
            isSearchActive = false
        } else {
            filteredSpecies = knownSpecies.filter { $0.lowercased().contains(query.lowercased()) }
            isSearchActive = true
        }
    }

    func fetchCurrentLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        } else {
            showLocationError("Location services are not enabled.")
        }
    }

    func uploadData() {
        let validationResults = validateFields()

        if validationResults.isEmpty {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(diatomUpload) {
                let jsonString = String(data: encoded, encoding: .utf8)
                print(jsonString ?? "Failed to encode to JSON")
            }
        } else {
            errorMessage = "Please correct the following errors before uploading:\n" + validationResults.joined(separator: "\n")
            isShowingErrorAlert = true
        }
    }

    func validateFields() -> [String] {
        var errors = [String]()

        if !validateName() {
            errors.append("Name must be a known species. Example: 'Asterionella formosa'.")
        }
        if !validateCoordinates(diatomUpload.location) {
            errors.append("Location must be in valid coordinate format (latitude, longitude). Example: '36.7783, -119.4179'.")
        }
        if diatomUpload.frustuleShape.isEmpty {
            errors.append("Frustule Shape is required.")
        }
        if diatomUpload.habitatType.isEmpty {
            errors.append("Habitat Type is required.")
        }
        if diatomUpload.waterBodyType.isEmpty {
            errors.append("Water Body Type is required.")
        }
        if diatomUpload.imageDescription.isEmpty {
            errors.append("Image Description is required.")
        }
        if diatomUpload.notes.isEmpty {
            errors.append("Notes are required.")
        }

        return errors
    }

    func validateName() -> Bool {
        return knownSpecies.contains(where: { $0.caseInsensitiveCompare(diatomUpload.name) == .orderedSame })
    }

    func validateCoordinates(_ location: String) -> Bool {
        let coordinateRegex = "^[-+]?([1-8]?\\d(\\.\\d+)?|90(\\.0+)?),\\s*[-+]?(180(\\.0+)?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d+)?)$"
        return NSPredicate(format: "SELF MATCHES %@", coordinateRegex).evaluate(with: location)
    }

    func showLocationError(_ message: String) {
        errorMessage = message
        isShowingErrorAlert = true
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            diatomUpload.location = "\(location.coordinate.latitude), \(location.coordinate.longitude)"
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        showLocationError("Failed to fetch location: \(error.localizedDescription)")
    }
}

