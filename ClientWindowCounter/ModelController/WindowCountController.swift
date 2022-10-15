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
    
    var windowCounts: [WindowCount] = []
    var filteredWindowCounts: [WindowCount] = []
    
    func filter(for client: Client) {
        filteredWindowCounts = windowCounts.filter { eachWindowCount in
            eachWindowCount.client == client
        }
    }
    
    //CRUD
    func createWindowCount(countDescription: String, bigWindow: Int, regularWindow: Int, smallWindow: Int, smallLadder: Int, bigLadder: Int, hardWater: Int, screen: Int, hardWaterSmall: Int, construction: Int, track: Int, discount: Double, totalPrice: String, client: Client) {
        let newWindowCount = WindowCount(countDescription: countDescription, bigWindow: bigWindow, regularWindow: regularWindow, smallWindow: smallWindow, smallLadder: smallLadder, bigLadder: bigLadder, hardWater: hardWater, screen: screen, hardWaterSmall: hardWaterSmall, construction: construction, track: track, discount: discount, totalPrice: totalPrice, client: client)
        windowCounts.append(newWindowCount)
        CoreDataStack.saveContext()
    }
    func fetchCounts() {
        let windowCounts = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        self.windowCounts = windowCounts
    }
    func deleteWindowCount(windowCount: WindowCount) {
        guard let index = windowCounts.firstIndex(of: windowCount),
              let filterIndex = filteredWindowCounts.firstIndex(of: windowCount)
        else { return }
        filteredWindowCounts.remove(at: filterIndex)
        windowCounts.remove(at: index)
        CoreDataStack.context.delete(windowCount)
        CoreDataStack.saveContext()
    }
    func updateWindowCount(windowCount: WindowCount) {
    }
    
}
