//
//  DailyPlanViewModel.swift
//  EatWell_V2
//
//  Created by Shilin Li on 17/06/2024.
//

import Foundation
import CoreData

// ViewModel for managing daily plans
class DailyPlanViewModel: ObservableObject {
    // Published property to notify views of changes
    @Published var dailyPlans: [DailyPlan] = []
    // Core Data context
    private let context: NSManagedObjectContext
    
    // Initializer with optional context parameter
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
        fetchDailyPlans() // Fetch existing daily plans on initialization
    }
    
    // Fetches all daily plans from the Core Data store
    func fetchDailyPlans() {
        let request: NSFetchRequest<DailyPlan> = DailyPlan.fetchRequest()
        do {
            dailyPlans = try context.fetch(request)
        } catch {
            print("Error fetching daily plans: \(error)")
        }
    }
    
    // Adds a new daily plan to the Core Data store
    func addDailyPlan(date: Date, breakfast: Recipe?, lunch: Recipe?, dinner: Recipe?) {
        let newPlan = DailyPlan(context: context)
        newPlan.id = UUID() // Assign a unique identifier
        newPlan.date = date
        newPlan.breakfast = breakfast
        newPlan.lunch = lunch
        newPlan.dinner = dinner
        saveContext() // Save the context to persist the new plan
        fetchDailyPlans() // Refresh the daily plans list
    }
    
    // Updates an existing daily plan
    func updateDailyPlan(plan: DailyPlan, breakfast: Recipe?, lunch: Recipe?, dinner: Recipe?) {
        plan.breakfast = breakfast
        plan.lunch = lunch
        plan.dinner = dinner
        saveContext() // Save the context to persist the updates
        fetchDailyPlans() // Refresh the daily plans list
    }
    
    // Deletes a daily plan from the Core Data store
    func deleteDailyPlan(plan: DailyPlan) {
        context.delete(plan)
        saveContext() // Save the context to persist the deletion
        fetchDailyPlans() // Refresh the daily plans list
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
