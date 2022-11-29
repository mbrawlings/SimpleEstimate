//
//  InvoicesTableCell.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 11/28/22.
//

import UIKit

class InvoicesTableCell: UITableViewCell {
    
    //MARK: - PROPERTIES
    var invoice: Invoice? {
        didSet {
            self.setupView()
        }
    }
    
    //MARK: - OUTLETS
    @IBOutlet weak var invoiceView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //MARK: - LIFECYCLES
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - HELPER METHODS
    func setupView() {
        guard let invoice else { return }
        Styling.styleCellWith(view: invoiceView)
        
        descriptionLabel.text = invoice.invoiceDescription
        priceLabel.text = String(format: "$%.2f",invoice.totalPrice)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
