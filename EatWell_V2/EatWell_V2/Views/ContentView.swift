//
//  ContentView.swift
//  EatWell_V2
//
//  Created by Shilin Li on 24/05/2024.
//

import SwiftUI
import Vision

// ImagePicker to select an image from the camera
struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

// The main view for displaying a list of food items
struct ContentView: View {
    // Access the managed object context from the environment
    @Environment(\.managedObjectContext) private var viewContext

    // Create a state object to manage the food items using the FoodItemViewModel
    @StateObject private var viewModel = FoodItemViewModel(context: PersistenceController.shared.container.viewContext)

    // State variables to control the presentation of the AddFoodItemView and ImagePicker
    @State private var isShowingAddFoodItemView = false
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?

    var body: some View {
        NavigationView {
            // List to display food items
            List {
                // Iterate over the food items in the view model
                ForEach(viewModel.foodItems) { item in
                    VStack(alignment: .leading) {
                        // Display the name of the food item
                        Text(item.name ?? "Unknown")
                            .font(.headline)
                        // Display the quantity and unit of the food item
                        Text("Quantity: \(item.quantity) \(item.unit ?? "")")
                        // Display the expiration date of the food item
                        Text("Expires: \(item.expirationDate ?? Date(), formatter: itemFormatter)")
                    }
                }
                // Enable deletion of food items
                .onDelete(perform: { indexSet in
                    indexSet.map { viewModel.foodItems[$0] }.forEach(viewModel.deleteFoodItem)
                })
            }
            // Set the navigation title
            .navigationTitle("Food Items")
            // Toolbar with edit, add, and photo buttons
            .toolbar {
                // Edit button to enable list editing
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                // Add button to present the AddFoodItemView
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingAddFoodItemView = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                // Camera button to present the ImagePicker
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingImagePicker = true
                    }) {
                        Label("Take Photo", systemImage: "camera")
                    }
                }
            }
            // Present the AddFoodItemView as a sheet when isShowingAddFoodItemView is true
            .sheet(isPresented: $isShowingAddFoodItemView) {
                AddFoodItemView(isPresented: $isShowingAddFoodItemView, viewModel: viewModel)
            }
            // Present the ImagePicker as a sheet when isShowingImagePicker is true
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $selectedImage)
                    .onChange(of: selectedImage) { _ in
                        if let image = selectedImage {
                            recognizeText(image: image)
                        }
                    }
            }
        }
    }

    // Recognize text from the selected image
    private func recognizeText(image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { (request, error) in
            guard error == nil else {
                print("Text recognition error: \(error!.localizedDescription)")
                return
            }
            if let observations = request.results as? [VNRecognizedTextObservation] {
                let recognizedStrings = observations.compactMap { $0.topCandidates(1).first?.string }
                let detectedText = recognizedStrings.joined(separator: "\n")
                parseDetectedText(detectedText)
            }
        }
        request.recognitionLevel = .accurate
        do {
            try requestHandler.perform([request])
        } catch {
            print("Failed to perform text recognition: \(error.localizedDescription)")
        }
    }

    // Parse the recognized text and update the view model
    private func parseDetectedText(_ text: String) {
        // Simplistic text parsing logic, to be improved based on actual text recognition format
        let lines = text.split(separator: "\n")
        if lines.count >= 5 {
            let name = String(lines[0])
            let quantity = Double(lines[1]) ?? 0
            let unit = String(lines[2])
            let isOpened = lines[3].lowercased() == "opened"
            let expirationDate = parseDate(String(lines[4]))

            viewModel.addFoodItem(
                name: name,
                quantity: quantity,
                unit: unit,
                isOpened: isOpened,
                expirationDate: expirationDate,
                categoryTag: ""
            )
        }
    }

    // Parse date string to Date object
    private func parseDate(_ dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: dateString) ?? Date()
    }
}

// DateFormatter to format the expiration date
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
