//
//  Recipe+CoreDataClass.swift
//  EatWell_V2
//
//  Created by Shilin Li on 30/05/2024.
//
//

import Foundation
import CoreData

@objc(Recipe)
public class Recipe: NSManagedObject {

}

extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var recipeDescription: String?
    @NSManaged public var include: NSSet?

}

// MARK: Generated accessors for include
extension Recipe {

    @objc(addIncludeObject:)
    @NSManaged public func addToInclude(_ value: FoodItem)

    @objc(removeIncludeObject:)
    @NSManaged public func removeFromInclude(_ value: FoodItem)

    @objc(addInclude:)
    @NSManaged public func addToInclude(_ values: NSSet)

    @objc(removeInclude:)
    @NSManaged public func removeFromInclude(_ values: NSSet)

}

extension Recipe : Identifiable {

}
