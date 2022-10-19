//
//  InvoiceTableViewCell.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/18/22.
//

import UIKit

protocol InvoiceTableViewCellDelegate: AnyObject {
//    func stepperValueChanged(for lineItem: LineItem)
    func stepperValueChanged()

}

class InvoiceTableViewCell: UITableViewCell {
    
    //MARK: - PROPERTIES
    private var lineItem: LineItem?
    weak var delegate: InvoiceTableViewCellDelegate?
    
    //MARK: - OUTLETS
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    
    //MARK: - LIFECYCLES
    override func awakeFromNib() {
        super.awakeFromNib()
        stepper.minimumValue = 0
        stepper.maximumValue = Double.infinity
    }

    //MARK: - ACTION
    @IBAction func productStepper(_ sender: UIStepper) {
        // setting stepper value to a constant
        let stepperQuantity = Int64(sender.value)
        // make that lineItem's quantity be the same value as my stepper
        lineItem?.quantity = stepperQuantity
        // make the label show the same quantity
        quantityLabel.text = "\(stepperQuantity)"
        // notify my delegate that the quantity changed to it can calculate
        // the running total at the bottom of the invoice
        delegate?.stepperValueChanged()
        //        guard let lineItem else { return }
        //        delegate?.stepperValueChanged(for: lineItem)
    }
    
    //MARK: - HELPER METHODS
    func updateViews(with lineItem: LineItem) {
        guard let product = lineItem.product else { return }
        productNameLabel.text = product.productName
        quantityLabel.text = "\(lineItem.quantity)"
        stepper.value = Double(lineItem.quantity)
        self.lineItem = lineItem
    }

}
