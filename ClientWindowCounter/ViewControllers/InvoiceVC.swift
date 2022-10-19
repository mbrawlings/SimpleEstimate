//
//  InvoiceVC.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import UIKit

struct ProductLineItem {
    var quantity: Int
    var product: Product
    var invoice: Invoice
}

class InvoiceVC: UIViewController {
    
    //MARK: - Properties
    var isNewInvoice = false
    var invoice: Invoice?
    var client: Client?
    var product: Product?
    private var lineItems: [LineItem] = []
    
    var discountChosen: Double = 1.0
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productDescription: UITextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var discountSegmentControl: UISegmentedControl!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        title = isNewInvoice ? "New Invoice" : "Invoice Details"
        setupView()
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    
    //MARK: - Action
    @IBAction func discountToggleAdjusted(_ sender: UISegmentedControl) {
        // change the invoice.discount every time toggle is adjusted
        switch sender.selectedSegmentIndex {
            //only set var to adjust var
        case 0:
            discountChosen = 1.0
        case 1:
            discountChosen = 0.9
        case 2:
            discountChosen = 0.85
        case 3:
            discountChosen = 0.8
        default:
            discountChosen = 1.0
        }
        // update totalPriceLabel
        let calculatedPrice = String(format: "$%.2f", calculateTotal())
        totalPriceLabel.text = calculatedPrice
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let invoice
        else { return }
        invoice.invoiceDescription = productDescription.text
        invoice.totalPrice = calculateTotal()
        if isNewInvoice {
            InvoiceController.shared.save(invoice: invoice)
        } else {
            InvoiceController.shared.updateInvoice(invoice: invoice, discount: discountChosen, totalPrice: invoice.totalPrice, invoiceDescription: invoice.invoiceDescription ?? "", client: client!)
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - HELPER METHODS
    private func setupView() {
        if isNewInvoice,
           let client = client {
            let invoice = Invoice(discount: 1.0, totalPrice: 0.00, invoiceDescription: "", client: client)
            self.invoice = invoice
            let lineItems = ProductController.shared.products.map { LineItem(quantity: 0, product: $0, invoice: invoice) }
            self.lineItems = lineItems
        } else if !isNewInvoice {
            guard let lineItemsSet = invoice?.lineItems else { return }
//            lineItemsSet.sorted(by: { $0. < $1.name })
            guard var lineItems = (lineItemsSet.allObjects as? [LineItem])
//                .sorted(by: { $0.d, <#LineItem#> in
//                <#code#>
//            })
            else { return }
            
            
            self.lineItems = lineItems
            guard let invoice else { return }
            // set discountChosen var
            discountChosen = invoice.discount //test
            // set where toggle is
            switch Double(invoice.discount) {
            case 1.0:
                discountSegmentControl.selectedSegmentIndex = 0
            case 0.9:
                discountSegmentControl.selectedSegmentIndex = 1
            case 0.85:
                discountSegmentControl.selectedSegmentIndex = 2
            case 0.8:
                discountSegmentControl.selectedSegmentIndex = 3
            default:
                discountSegmentControl.selectedSegmentIndex = 0
            }
            // set description
            self.productDescription.text = invoice.invoiceDescription
            // set total price
            self.totalPriceLabel.text = String(format: "$%.2f", invoice.totalPrice)
        }
        tableView.reloadData()
    }
    
    func calculateTotal() -> Double {
//        guard let discount = invoice?.discount else { return 1.0 }
        var sum = 0.0
        for lineItem in lineItems {
            let quantity = Double(lineItem.quantity)
            let price = (lineItem.product?.price) ?? 0.0
            sum += quantity * price
        }
//        sum = sum * discount
        sum = sum * discountChosen
        return sum
    }
}

    //MARK: - TABLEVIEW METHODS
extension InvoiceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        ProductController.shared.products.count
        lineItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "lineItemCell", for: indexPath) as? InvoiceTableViewCell else { return UITableViewCell() }
        
        let lineItem = lineItems[indexPath.row]
        
        cell.delegate = self
        
        cell.updateViews(with: lineItem)
        
        return cell
    }
}

    //MARK: - INVOICE CELL DELEGATE
extension InvoiceVC: InvoiceTableViewCellDelegate {
    func stepperValueChanged() {
//    func stepperValueChanged(for lineItem: LineItem) {
//        guard let lineItem = lineItems.firstIndex(of: lineItem)
//        else { return }
        
        let calculatedPrice = String(format: "$%.2f", calculateTotal())
        totalPriceLabel.text = calculatedPrice
        
//        totalPriceLabel.text = "\(calculateTotal())"
        
    }
    
    
}
