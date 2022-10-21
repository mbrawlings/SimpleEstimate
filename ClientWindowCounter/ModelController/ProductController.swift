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
    func createProduct(productName: String, price: Double) {
        let newProduct = Product(productName: productName, price: price)
        products.append(newProduct)
        CoreDataStack.saveContext()
        fetchProducts()
    }
    
    func fetchProducts() {
        var products = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        products.sort(by: { lhs, rhs in
            guard let lhsDate = lhs.creationDate,
                  let rhsDate = rhs.creationDate
            else { return true }
            return lhsDate < rhsDate
        })
        self.products = products
    }
    
    func deleteProduct(product: Product) {
        guard let index = products.firstIndex(of: product) else { return }
        products.remove(at: index)
        CoreDataStack.context.delete(product)
        CoreDataStack.saveContext()
        fetchProducts()
    }
    
    func editProduct(product: Product, productName: String, price: Double) {
        product.productName = productName
        product.price = price
        CoreDataStack.saveContext()
    }
}
