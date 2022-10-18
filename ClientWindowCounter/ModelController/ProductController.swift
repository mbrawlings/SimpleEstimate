//
//  ProductController.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/17/22.
//

import Foundation
import CoreData

class ProductController {
    static let shared = ProductController()
    
    var products: [Product] = []
    
    private init() {
        fetchProducts()
    }
    
    private lazy var fetchRequest: NSFetchRequest<Product> = {
        let request = NSFetchRequest<Product>(entityName: "Product")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    //CRUD
    func updateProducts(text: String, price: Double, amount: Int) {
        let newProduct = Product(text: text, price: price, amount: Int64(amount))
        products.append(newProduct)
        CoreDataStack.saveContext()
    }
    
    func fetchProducts() {
        let products = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []

        self.products = products
    }
    
    func deleteProducts() {
        
    }
}
