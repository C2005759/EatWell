//
//  ShoppingListViewModel.swift
//  EatWell_V2
//
//  Created by Shilin Li on 25/06/2024.
//

import Foundation
import CoreData

// ViewModel for managing shopping lists
class ShoppingListViewModel: ObservableObject {
    // Published property to notify views of changes
    @Published var shoppingList: [ShoppingList] = []
    // Core Data context
    private let context: NSManagedObjectContext
    
    // Initializer with optional context parameter
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
        fetchShoppingList() // Fetch existing shopping lists on initialization
    }
    
    // Fetches all shopping lists from the Core Data store
    func fetchShoppingList() {
        let request: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        do {
            shoppingList = try context.fetch(request)
        } catch {
            print("Error fetching shopping lists: \(error)")
        }
    }
    
    // Adds a new shopping list to the Core Data store
    func addShoppingList(foodItems: [FoodItem]) {
        let newItem = ShoppingList(context: context)
        newItem.id = UUID() // Assign a unique identifier
        newItem.foodItems = NSSet(array: foodItems)
        saveContext() // Save the context to persist the new item
        fetchShoppingList() // Refresh the shopping lists
    }
    
    // Updates an existing shopping list
    func updateShoppingList(item: ShoppingList, foodItems: [FoodItem]) {
        item.foodItems = NSSet(array: foodItems)
        saveContext() // Save the context to persist the updates
        fetchShoppingList() // Refresh the shopping lists
    }
    
    // Deletes a shopping list from the Core Data store
    func deleteShoppingList(list: ShoppingList) {
        context.delete(list)
        saveContext() // Save the context to persist the deletion
        fetchShoppingList() // Refresh the shopping lists
    }
    
    // Saves the Core Data context, handling any errors
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
