//
//  InvoiceTableCell.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/18/22.
//

import UIKit

protocol InvoiceTableViewCellDelegate: AnyObject {
    func shadowStepperValueChanged(for shadowLineItem: ShadowLineItem)
    func stepperValueChanged()
}

class InvoiceTableCell: UITableViewCell {
    
    //MARK: - PROPERTIES
    private var lineItem: LineItem?
    var shadowLineItem: ShadowLineItem?
    weak var delegate: InvoiceTableViewCellDelegate?
    var isNewInvoice = false
    
    //MARK: - OUTLETS
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var productInvoiceView: UIView!
    
    //MARK: - LIFECYCLES
    override func awakeFromNib() {
        super.awakeFromNib()
        stepper.minimumValue = 0
        stepper.maximumValue = Double.infinity
    }

    //MARK: - ACTION
    @IBAction func productStepper(_ sender: UIStepper) {
        if isNewInvoice {
            let stepperQuantity = Int64(sender.value)
            lineItem?.quantity = stepperQuantity
            quantityLabel.text = "\(stepperQuantity)"
            delegate?.stepperValueChanged()
        } else {
            guard var shadowLineItem else { return }
            let stepperQuantity = Int64(sender.value)
            shadowLineItem.quantity = stepperQuantity
            quantityLabel.text = "\(stepperQuantity)"
            delegate?.shadowStepperValueChanged(for: shadowLineItem)
        }
    }
    
    //MARK: - HELPER METHODS
    func updateViews(with lineItem: LineItem) {
        self.isNewInvoice = true
        guard let product = lineItem.product else { return }
        productNameLabel.text = product.productName
        quantityLabel.text = "\(lineItem.quantity)"
        stepper.value = Double(lineItem.quantity)
        Styling.styleCellWith(view: productInvoiceView)
        self.lineItem = lineItem
    }
    func updateViews(with lineItem: ShadowLineItem) {
        productNameLabel.text = lineItem.product.productName
        quantityLabel.text = "\(lineItem.quantity)"
        stepper.value = Double(lineItem.quantity)
        Styling.styleCellWith(view: productInvoiceView)
        self.shadowLineItem = lineItem
    }
}
