//
//  Persistence.swift
//  EatWell_V2
//
//  Created by Shilin Li on 12/06/2024.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // 创建一些示例数据
        for _ in 0..<10 {
            let newItem = FoodItem(context: viewContext)
            newItem.id = UUID()
            newItem.name = "Sample Food Item"
            newItem.quantity = 1.0
            newItem.unit = "kg"
            newItem.isOpened = false
            newItem.expirationDate = Date()
            newItem.categoryTag = "Sample Tag"
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "EatWell_V2")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
