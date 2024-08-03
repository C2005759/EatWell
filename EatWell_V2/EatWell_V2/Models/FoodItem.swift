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

}

extension FoodItem : Identifiable {

}
