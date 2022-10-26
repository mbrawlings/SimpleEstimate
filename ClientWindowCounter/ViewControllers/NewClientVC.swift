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
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        if !isNewClient {
            viewsToEditClient()
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
        title = isNewClient ? "New Client" : "Edit Client"
        nameTextField.layer.borderWidth = 0.5
        nameTextField.layer.cornerRadius = 10.0
        nameTextField.layer.masksToBounds = true
        
        addressTextField.layer.borderWidth = 0.5
        addressTextField.layer.cornerRadius = 10.0
        addressTextField.layer.masksToBounds = true
        
        cityTextField.layer.borderWidth = 0.5
        cityTextField.layer.cornerRadius = 10.0
        cityTextField.layer.masksToBounds = true
        
        stateTextField.layer.borderWidth = 0.5
        stateTextField.layer.cornerRadius = 10.0
        stateTextField.layer.masksToBounds = true
        
        phoneTextField.layer.borderWidth = 0.5
        phoneTextField.layer.cornerRadius = 10.0
        phoneTextField.layer.masksToBounds = true
    }
    
    
    func viewsToEditClient() {
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
