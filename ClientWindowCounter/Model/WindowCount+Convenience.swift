//
//  ClientWindowCounter+Convenience.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import CoreData

extension WindowCount {
    @discardableResult convenience init(countDescription: String, bigWindow: Int, regularWindow: Int, smallWindow: Int, smallLadder: Int, bigLadder: Int, hardWater: Int, screen: Int, hardWaterSmall: Int, construction: Int, track: Int, discount: Double, totalPrice: Double, client: Client, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.countDescription = countDescription
        self.bigWindow = Int64(bigWindow)
        self.regularWindow = Int64(regularWindow)
        self.smallWindow = Int64(smallWindow)
        self.smallLadder = Int64(smallLadder)
        self.bigLadder = Int64(bigLadder)
        self.screen = Int64(screen)
        self.hardWater = Int64(hardWater)
        self.hardWaterSmall = Int64(hardWaterSmall)
        self.construction = Int64(construction)
        self.track = Int64(track)
        self.discount = discount
        self.totalPrice = totalPrice
        self.client = client
    }
}
