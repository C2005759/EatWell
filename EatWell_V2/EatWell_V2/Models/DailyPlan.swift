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
    @NSManaged public var date: Date
    @NSManaged public var breakfast: Recipe?
    @NSManaged public var lunch: Recipe?
    @NSManaged public var dinner: Recipe?
    
    var isFilled: Bool {
        return breakfast != nil && lunch != nil && dinner != nil
    }
    
    
/// Helper method to add a recipe to the daily plan
    func add(recipe: Recipe) {
        let items = self.mutableSetValue(forKey: "recipes")
        items.add(recipe)
    }
    
    /// Helper method to remove a recipe from the daily plan
    func remove(recipe: Recipe) {
        let items = self.mutableSetValue(forKey: "recipes")
        items.remove(recipe)
    }

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
