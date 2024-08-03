//
//  FoodItem+CoreDataClass.swift
//  EatWell_V2
//
//  Created by Shilin Li on 24/05/2024.
//
//

import Foundation
import CoreData

@objc(FoodItem)
public class FoodItem: NSManagedObject {

}

extension FoodItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var quantity: Double
    @NSManaged public var unit: String?
    @NSManaged public var isOpened: Bool
    @NSManaged public var expirationDate: Date?
    @NSManaged public var categoryTag: String?

/// Function to check if the item is about to expire
    var isAboutToExpire: Bool {
        guard let expirationDate = expirationDate else { return false }
        return expirationDate.timeIntervalSinceNow < 3 * 24 * 60 * 60 // 3 days
    }
    
    /// Function to update food item details
    func update(name: String?, quantity: Double, unit: String?, isOpened: Bool, expirationDate: Date?, categoryTag: String?) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.isOpened = isOpened
        self.expirationDate = expirationDate
        self.categoryTag = categoryTag
    }
}

extension FoodItem : Identifiable {

}
