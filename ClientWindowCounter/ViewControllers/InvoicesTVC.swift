//
//  InvoicesTVC.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import UIKit

class InvoicesTVC: UITableViewController {
    
    //MARK: - PROPERTIES
    var client: Client?

    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        InvoiceController.shared.fetchInvoices()
        guard let client = client else { return }
        InvoiceController.shared.filter(for: client)
        tableView.reloadData()
    }

    // MARK: - TABLE VIEW DATA SOURCE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InvoiceController.shared.filteredInvoices.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "invoiceCell", for: indexPath)
        let invoice = InvoiceController.shared.filteredInvoices[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = String(format: "$%.2f", invoice.totalPrice)
        
        content.secondaryText = invoice.invoiceDescription
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let invoiceToDelete = InvoiceController.shared.filteredInvoices[indexPath.row]
            InvoiceController.shared.deleteInvoice(invoice: invoiceToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    // MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewInvoice" {
            guard let destination = segue.destination as? InvoiceVC else { return }
            destination.client = self.client
            destination.isNewInvoice = true
        }
        if segue.identifier == "toInvoiceDetails" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? InvoiceVC else { return }
            let invoiceToEdit = InvoiceController.shared.filteredInvoices[indexPath.row]
            destination.client = self.client
            destination.invoice = invoiceToEdit
        }
    }

}
