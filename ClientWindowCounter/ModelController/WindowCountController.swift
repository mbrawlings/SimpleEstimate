//
//  WindowCountController.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import CoreData

class WindowCountController {
    static let shared = WindowCountController()
    
    private init() {
        fetchCounts()
    }
    
    private lazy var fetchRequest: NSFetchRequest<WindowCount> = {
        let request = NSFetchRequest<WindowCount>(entityName: "WindowCount")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
//    var client: [Client]
//    var clients: [[Client]]
    var windowCounts: [WindowCount] = []
//    var clientWindows: [[client]:[windowCount]]
    
    //CRUD
    func createWindowCount(countDescription: String, bigWindow: Int, regularWindow: Int, smallWindow: Int, smallLadder: Int, bigLadder: Int, hardWater: Int, screen: Int, hardWaterSmall: Int, construction: Int, track: Int, discount: Double, totalPrice: Double) {
        let newWindowCount = WindowCount(countDescription: countDescription, bigWindow: bigWindow, regularWindow: regularWindow, smallWindow: smallWindow, smallLadder: smallLadder, bigLadder: bigLadder, hardWater: hardWater, screen: screen, hardWaterSmall: hardWaterSmall, construction: construction, track: track, discount: discount, totalPrice: totalPrice)
        windowCounts.append(newWindowCount)
        CoreDataStack.saveContext()
    }
    func fetchCounts() {
        let windowCount = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        self.windowCounts = windowCount
    }
    func deleteWindowCount(windowCount: WindowCount) {
        guard let index = windowCounts.firstIndex(of: windowCount) else { return }
        windowCounts.remove(at: index)
        CoreDataStack.context.delete(windowCount)
        CoreDataStack.saveContext()
    }
    func editWindowCount() {
        
    }
    
}
