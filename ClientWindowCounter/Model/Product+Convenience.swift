//
//  Product+Convenience.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/17/22.
//

import CoreData

extension Product {
    @discardableResult convenience init(creationDate: Date = Date(), productName: String, price: Double, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.creationDate = creationDate
        self.productName = productName
        self.price = price
    }
}
