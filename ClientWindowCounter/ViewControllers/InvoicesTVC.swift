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
        Styling.styleBackgroundFor(view: view, tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        InvoiceController.shared.fetchInvoices()
        guard let client = client else { return }
        InvoiceController.shared.filter(for: client)
        tableView.reloadData()
    }

    // MARK: - TABLE VIEW DATA SOURCE
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InvoiceController.shared.filteredInvoices.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "invoiceCell", for: indexPath) as? InvoicesTableCell else { return UITableViewCell() }
        
        let invoice = InvoiceController.shared.filteredInvoices[indexPath.row]
        
        cell.invoice = invoice
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            self?.handleDeleteInvoice(indexPath: indexPath)
            completionHandler(true)
        }
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
    func handleDeleteInvoice(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete?", message: "This action cannot be undone", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            let invoiceToDelete = InvoiceController.shared.filteredInvoices[indexPath.row]
            InvoiceController.shared.deleteInvoice(invoice: invoiceToDelete)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
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
