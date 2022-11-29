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
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        Styling.styleBackgroundFor(view: view, tableView: nil)
        setupView()
        if !isNewClient {
            viewsToEditClient()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nameTextField.becomeFirstResponder()
    }
    
    //MARK: - ACTION
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard let street = streetTextField.text,
              let city = cityTextField.text,
              let state = stateTextField.text
        else { return }
        guard let name = nameTextField.text,
              !name.isEmpty
        else {
            present(Alert.error(message: "Must enter a client name"), animated: true)
            return }
        guard let phoneNumberString = phoneTextField.text else { return }
        var phoneNumber: Int64 = 0
        if !phoneNumberString.isEmpty {
            guard let phoneNumberInt = Int64(phoneNumberString),
                  phoneNumberString.count == 10
            else {
                print(phoneNumberString)
                present(Alert.error(message: "Must be 10 digits only"), animated: true)
                return }
            phoneNumber = phoneNumberInt
        }
        if isNewClient {
            ClientController.shared.createClient(name: name, streetAddress: street, cityAddress: city, stateAddress: state, phoneNumber: phoneNumber)
        } else if !isNewClient {
            guard let client else { return }
            ClientController.shared.editClient(client: client, name: name, streetAddress: street, cityAddress: city, stateAddress: state, phoneNumber: phoneNumber)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismissKeyboardGestureTapped(_ sender: Any) {
        nameTextField.resignFirstResponder()
        streetTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        stateTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }
    
    //MARK: - HELPER METHODS
    func setupView() {
        title = isNewClient ? "New Client" : "Edit Client"
        Styling.styleTextFieldWith(textField: nameTextField)
        Styling.styleTextFieldWith(textField: streetTextField)
        Styling.styleTextFieldWith(textField: cityTextField)
        Styling.styleTextFieldWith(textField: stateTextField)
        Styling.styleTextFieldWith(textField: phoneTextField)
    }
    
    func viewsToEditClient() {
        guard let client else { return }
        nameTextField.text = client.name
        streetTextField.text = client.streetAddress
        cityTextField.text = client.cityAddress
        stateTextField.text = client.stateAddress
        phoneTextField.text = client.phoneNumber == 0 ? "" : "\(client.phoneNumber)"
    }
}
