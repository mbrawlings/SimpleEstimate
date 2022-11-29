//
//  ProductTableCell.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 11/25/22.
//

import UIKit

class ProductTableCell: UITableViewCell {
    
    //MARK: PROPERTIES
    var product: Product? {
        didSet {
            setupViews()
        }
    }
    
    //MARK: OUTLETS
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //MARK: LIFECYCLES
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: HELPER METHODS
    func setupViews() {
        guard let product = product else { return }
        productLabel.text = product.productName
        priceLabel.text = String(format: "$%.2f", product.price)
        Styling.styleCellWith(view: view)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
