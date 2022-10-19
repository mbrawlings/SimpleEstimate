//
//  LineItem+Convenience.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/18/22.
//

import Foundation
import CoreData

extension LineItem {
    @discardableResult convenience init(quantity: Int64, product: Product, invoice: Invoice, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.quantity = quantity
        self.product = product
        self.invoice = invoice
    }
}
