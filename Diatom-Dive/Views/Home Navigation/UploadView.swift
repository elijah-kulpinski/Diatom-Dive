//
//  UploadView.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 3/28/24.
//
import Foundation
import SwiftUI

struct UploadView: View {
    @ObservedObject var viewModel = UploadViewModel()
    @State private var isShowingImagePicker = false  // State to manage the presentation of the image picker
    let frustuleShapes = ["Elliptical", "Linear", "Triangular", "Circular"]  // Example shapes

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Diatom Image")) {
                    if let image = viewModel.image {
                        image.resizable().scaledToFit()
                    }
                    Button("Select Image") {
                        isShowingImagePicker = true  // Trigger the image picker presentation
                    }
                }
                
                Section(header: Text("Metadata")) {
                    SpeciesPicker(species: $viewModel.diatomUpload.name, viewModel: viewModel)
                    TextField("Name", text: $viewModel.diatomUpload.name)

                    HStack {
                        TextField("Location Discovered", text: $viewModel.diatomUpload.location)
                        Button(action: viewModel.fetchCurrentLocation) {
                            Image(systemName: "location.circle")
                        }
                    }
                    Picker("Frustule Shape", selection: $viewModel.diatomUpload.frustuleShape) {
                        ForEach(frustuleShapes, id: \.self) { shape in
                            Text(shape).tag(shape)
                        }
                    }
                    DatePicker("Date/Time", selection: $viewModel.diatomUpload.dateTime, displayedComponents: [.date, .hourAndMinute])
                    TextField("Habitat Type", text: $viewModel.diatomUpload.habitatType)
                    TextField("Water Body Type", text: $viewModel.diatomUpload.waterBodyType)
                    TextField("Image Description", text: $viewModel.diatomUpload.imageDescription)
                    TextField("Notes", text: $viewModel.diatomUpload.notes)
                }
                
                Section {
                    Button("Upload Data") {
                        viewModel.uploadData()
                    }
                }
            }
            .alert(isPresented: $viewModel.isShowingErrorAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Upload Diatom Data")
            .background(Color("BackgroundColor"))
            .sheet(isPresented: $isShowingImagePicker) {  // Present the image picker
                ImagePicker(sourceType: .photoLibrary) { image in
                    viewModel.image = Image(uiImage: image)  // Update the view model with the selected image
                }
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    var onImagePicked: (UIImage) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.onImagePicked(uiImage)
            }
            picker.dismiss(animated: true)
        }
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
