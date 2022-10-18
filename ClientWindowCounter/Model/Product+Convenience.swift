//
//  Product+Convenience.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/17/22.
//

import CoreData

extension Product {
    @discardableResult convenience init(text: String, price: Double, amount: Int64, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.text = text
        self.price = price
        self.amount = amount
    }
}
