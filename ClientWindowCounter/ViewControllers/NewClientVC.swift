//
//  NewClientVC.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import UIKit

class NewClientVC: UIViewController {
    
    //MARK: - PROPERTIES
    var client: Client?
    var isNewClient = true
    
    //MARK: - OUTLETS
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        title = isNewClient ? "New Client" : "Edit Client"
        if !isNewClient {
            setupView()
        }
    }
    
    //MARK: - ACTION
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text,
              !name.isEmpty,
              let address = addressTextField.text
        else {
            let alert = UIAlertController(title: "Error", message: "Must enter a client name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .default))
            present(alert, animated: true)
            return }
        guard let phoneNumberString = phoneTextField.text else { return }
        var phoneNumber: Int64 = 0
        if !phoneNumberString.isEmpty {
            guard let phoneNumberInt = Int64(phoneNumberString),
                  phoneNumberString.count == 10
            else {
                print(phoneNumberString)
                let alert = UIAlertController(title: "Error", message: "Must be 10 digits only", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Got it!", style: .default))
                present(alert, animated: true)
                return }
            phoneNumber = phoneNumberInt
        }
        if isNewClient {
            ClientController.shared.createClient(name: name, address: address, phoneNumber: phoneNumber)
        } else if !isNewClient {
            guard let client else { return }
            ClientController.shared.editClient(client: client, name: name, address: address, phoneNumber: phoneNumber)
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - HELPER METHODS
    func setupView() {
        guard let client else { return }
        nameTextField.text = client.name
        addressTextField.text = client.address
        phoneTextField.text = client.phoneNumber == 0 ? "" : "\(client.phoneNumber)"
    }

    /*
    // MARK: - NAVIGATION

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
