//
//  Client+Convenience.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import CoreData

extension Client {
    @discardableResult convenience init(name: String, streetAddress: String, cityAddress: String, stateAddress: String, phoneNumber: Int64, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.streetAddress = streetAddress
        self.cityAddress = cityAddress
        self.stateAddress = stateAddress
        self.phoneNumber = phoneNumber
    }
}
