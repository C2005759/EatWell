//
//  DailyPlan+CoreDataClass.swift
//  EatWell_V2
//
//  Created by Shilin Li on 31/05/2024.
//
//

import Foundation
import CoreData

@objc(DailyPlan)
public class DailyPlan: NSManagedObject {

}

extension DailyPlan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyPlan> {
        return NSFetchRequest<DailyPlan>(entityName: "DailyPlan")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var recipes: NSSet?

}

// MARK: Generated accessors for recipes
extension DailyPlan {

    @objc(addRecipesObject:)
    @NSManaged public func addToRecipes(_ value: Recipe)

    @objc(removeRecipesObject:)
    @NSManaged public func removeFromRecipes(_ value: Recipe)

    @objc(addRecipes:)
    @NSManaged public func addToRecipes(_ values: NSSet)

    @objc(removeRecipes:)
    @NSManaged public func removeFromRecipes(_ values: NSSet)

}

extension DailyPlan : Identifiable {

}
