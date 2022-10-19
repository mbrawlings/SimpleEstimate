//
//  Invoice+Convenience.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/18/22.
//

import Foundation
import CoreData

extension Invoice {
    @discardableResult convenience init(discount: Double, totalPrice: Double, invoiceDescription: String, client: Client, /*lineItem: [LineItem], */context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.discount = discount
        self.totalPrice = totalPrice
        self.invoiceDescription = invoiceDescription
        self.client = client
//        self.lineItem = [lineItem]
    }
}
