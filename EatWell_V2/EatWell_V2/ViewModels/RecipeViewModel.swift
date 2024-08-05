//
//  RecipeViewModel.swift
//  EatWell_V2
//
//  Created by Shilin Li on 12/06/2024.
//

import Foundation
import CoreData
import SwiftUI

// ViewModel class for managing Recipe entities
class RecipeViewModel: ObservableObject {
    private var viewContext: NSManagedObjectContext
    
    // Initializer to inject the managed object context
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchRecipes()
    }
    
    // Published property to notify the view about changes
    @Published var recipes: [Recipe] = []
    
    // Fetch Recipe entities from the Core Data store
    func fetchRecipes() {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        do {
            recipes = try viewContext.fetch(request)
        } catch {
            print("Error fetching recipes: \(error)")
        }
    }
    
    /// Adds a new recipe item to the Core Data context
    func addRecipe(name: String, recipeDescription: String, steps: String, foodItems: [FoodItem], image: UIImage?, isWanted: Bool){
        let newItem = Recipe(context: viewContext)
        newItem.id = UUID()
        newItem.name = name
        newItem.recipeDescription = recipeDescription
        newItem.steps = steps
        newItem.isWanted = isWanted
        newItem.foodItems = NSSet(array: foodItems) // Convert to NSSet
        
        // Convert UIImage to Data and assign to image property
        if let image = image, let imageData = image.jpegData(compressionQuality: 1.0) {
            newItem.image = imageData
        }
        
        fetchRecipes()
        saveContext()
    }
    
    /// Updates an existing recipe item in the Core Data context
    func updateRecipe(item: Recipe, name: String, recipeDescription: String, steps: String, fooditems: [FoodItem], image: UIImage?, isWanted: Bool) {
        item.name = name
        item.recipeDescription = recipeDescription
        item.steps = steps
        item.isWanted = isWanted
        item.foodItems = NSSet(array: fooditems)
        
        if let image = image, let imageData = image.jpegData(compressionQuality: 1.0) {
            item.image = imageData
        }
        
        saveContext()
        fetchRecipes()
    }
    
    /// Delete an exisiting recipe item from the Core Data context
    func deleteRecipe(item: Recipe) {
        viewContext.delete(item)
        saveContext()
        fetchRecipes()
    }
    
    /// save changes to the Core Data context.
    func saveContext(){
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error saving recipes context: \(error)")
            }
        }
    }
}
