//
//  ClientTableViewCell.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/26/22.
//

import UIKit

class ClientTableViewCell: UITableViewCell {
    
    //MARK: - PROPERTIES
    var client: Client? {
        didSet {
            DispatchQueue.main.async {
                self.setupView()
            }
        }
    }
    
    //MARK: - OUTLETS
    @IBOutlet weak var clientView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    

    //MARK: - LIFECYCLES
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clientView.layer.borderWidth = 1.0
        clientView.layer.cornerRadius = clientView.frame.height / 10
//        clientView.backgroundColor = .systemGray6
    }
    
    //MARK: - HELPER METHODS
    func setupView() {
        guard let client = client else { return }
        nameLabel.text = client.name
        if let street = client.streetAddress,
           let city = client.cityAddress,
           let state = client.stateAddress {
            if street == "" && city == "" && state == "" {
                addressLabel.text = "-"
            } else {
                addressLabel.text = "\(street) \(city) \(state)"
            }
            if client.phoneNumber == 0 {
                phoneLabel.text = "-"
            } else {
                phoneLabel.text = "\(client.phoneNumber)".applyPatternOnNumbers()
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
