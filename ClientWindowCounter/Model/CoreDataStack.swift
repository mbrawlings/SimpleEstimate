//
//  CoreDataStack.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import CoreData

enum CoreDataStack {

   static let container: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "ClientWindowCounter")
      container.loadPersistentStores { storeDescription, error in
         if let error = error {
            fatalError("Error loading persistent stores \(error)")
         }
      }
      return container
   }()

   static var context: NSManagedObjectContext { container.viewContext }

   static func saveContext() {
      if context.hasChanges {
         do {
            try context.save()
         } catch {
            NSLog("Error saving context \(error)")
         }
      }
   }
}
