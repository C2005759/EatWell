//
//  ShoppingList+CoreDataClass.swift
//  EatWell_V2
//
//  Created by Shilin Li on 31/05/2024.
//
//

import Foundation
import CoreData

@objc(ShoppingList)
public class ShoppingList: NSManagedObject {

}
extension ShoppingList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingList> {
        return NSFetchRequest<ShoppingList>(entityName: "ShoppingList")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var foodItems: NSSet?
    
/// Function to add a food item to the shopping list
    func add(foodItem: FoodItem) {
        let items = self.mutableSetValue(forKey: "foodItems")
        items.add(foodItem)
    }
    
    /// Function to remove a food item from the shopping list
    func remove(foodItem: FoodItem) {
        let items = self.mutableSetValue(forKey: "foodItems")
        items.remove(foodItem)
    }
    
    /// Function to clear the shopping list
    func clear() {
        self.foodItems = nil
    }

}

// MARK: Generated accessors for foodItems
extension ShoppingList {

    @objc(addFoodItemsObject:)
    @NSManaged public func addToFoodItems(_ value: FoodItem)

    @objc(removeFoodItemsObject:)
    @NSManaged public func removeFromFoodItems(_ value: FoodItem)

    @objc(addFoodItems:)
    @NSManaged public func addToFoodItems(_ values: NSSet)

    @objc(removeFoodItems:)
    @NSManaged public func removeFromFoodItems(_ values: NSSet)

}

extension ShoppingList : Identifiable {

}
