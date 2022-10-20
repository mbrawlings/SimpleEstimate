//
//  InvoiceController.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/18/22.
//

import Foundation
import CoreData

class InvoiceController {
    static let shared = InvoiceController()
    
    var invoices: [Invoice] = []
    var filteredInvoices: [Invoice] = []
    
    private init() {
        fetchInvoices()
    }
    
    private lazy var fetchRequest: NSFetchRequest<Invoice> = {
        let request = NSFetchRequest<Invoice>(entityName: "Invoice")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    

    func filter(for client: Client) {
        filteredInvoices = invoices.filter { eachInvoice in
            eachInvoice.client == client
        }
    }
    
    //CRUD
    func createInvoice(discount: Double, totalPrice: Double, invoiceDescription: String, client: Client) {
        let newInvoice = Invoice(discount: discount, totalPrice: totalPrice, invoiceDescription: invoiceDescription, client: client)
        invoices.append(newInvoice)
        CoreDataStack.saveContext()
    }
    func save(invoice: Invoice) {
        invoices.append(invoice)
        CoreDataStack.saveContext()
    }
    
    func fetchInvoices() {
        let invoices = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        self.invoices = invoices
    }
    func deleteInvoice(invoice: Invoice) {
        guard let index = invoices.firstIndex(of: invoice),
              let filterIndex = filteredInvoices.firstIndex(of: invoice)
        else { return }
        filteredInvoices.remove(at: filterIndex)
        invoices.remove(at: index)
        CoreDataStack.context.delete(invoice)
        CoreDataStack.saveContext()
    }
    func updateInvoice(invoice: Invoice, discount: Double, totalPrice: Double, invoiceDescription: String, client: Client) {
        invoice.discount = discount
        invoice.totalPrice = totalPrice
        invoice.invoiceDescription = invoiceDescription
        invoice.client = client
        CoreDataStack.saveContext()
    }
}
