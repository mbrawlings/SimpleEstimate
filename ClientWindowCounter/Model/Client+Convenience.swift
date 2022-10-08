//
//  Client+Convenience.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import CoreData

extension Client {
    @discardableResult convenience init(name: String, address: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.address = address
    }
}
