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
