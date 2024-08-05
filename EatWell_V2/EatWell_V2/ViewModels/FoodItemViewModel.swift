//
//  FoodItemViewModel.swift
//  EatWell_V2
//
//  Created by Shilin Li on 31/05/2024.
//

import Foundation
import CoreData
import Vision
import UIKit


/// ViewModel for managing food items
class FoodItemViewModel: ObservableObject {
    @Published var foodItems: [FoodItem] = []
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
        fetchFoodItems()
    }

    /// Fetches all food items from the Core Data context
    func fetchFoodItems() {
        let request: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        do {
            foodItems = try context.fetch(request)
        } catch {
            print("Error fetching food items: \(error)")
        }
    }

    /// Adds a new food item to the Core Data context
    func addFoodItem(name: String, quantity: Double, unit: String, isOpened: Bool, expirationDate: Date?, categoryTag: String?) {
        let newItem = FoodItem(context: context)
        newItem.id = UUID()
        newItem.name = name
        newItem.quantity = quantity
        newItem.unit = unit
        newItem.isOpened = isOpened
        newItem.expirationDate = expirationDate
        newItem.categoryTag = categoryTag
        saveContext()
        fetchFoodItems()
    }

    /// Updates an existing food item in the Core Data context
    func updateFoodItem(item: FoodItem, name: String, quantity: Double, unit: String, isOpened: Bool, expirationDate: Date?, categoryTag: String?) {
        item.name = name
        item.quantity = quantity
        item.unit = unit
        item.isOpened = isOpened
        item.expirationDate = expirationDate
        item.categoryTag = categoryTag
        saveContext()
        fetchFoodItems()
    }

    /// Deletes a food item from the Core Data context
    func deleteFoodItem(item: FoodItem) {
        context.delete(item)
        saveContext()
        fetchFoodItems()
    }

    /// Saves changes to the Core Data context
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    
    
    
    
    
    /// Recognizes expiration date from the given image
    func recognizeExpirationDate(from image: UIImage, completion: @escaping (String?) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(nil)
            return
        }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { (request, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            let observations = request.results as? [VNRecognizedTextObservation]
            let recognizedStrings = observations?.compactMap { $0.topCandidates(1).first?.string }
            let expirationDateString = recognizedStrings?.first(where: { self.isValidDate($0) })
            completion(expirationDateString)
        }
        request.recognitionLevel = .accurate

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch {
                completion(nil)
            }
        }
    }

    /// Validates if a string is a valid date
    private func isValidDate(_ string: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy" // Adjust date format based on expected input
        return dateFormatter.date(from: string) != nil
    }
}

