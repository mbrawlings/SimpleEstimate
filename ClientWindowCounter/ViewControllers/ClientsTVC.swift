//
//  ClientsTVC.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import UIKit
import CoreLocation

class ClientsTVC: UITableViewController {
    
    //MARK: - OUTLETS
    

    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ClientController.shared.fetchClients()
        tableView.reloadData()
    }

    // MARK: - TABLE VIEW METHODS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClientController.shared.clients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientCell", for: indexPath)

        let client = ClientController.shared.clients[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        
        content.text = client.name
        if let address = client.address {
            if address == "" && client.phoneNumber == 0 {
                content.secondaryText = "-\n-"
            } else if address == "" && client.phoneNumber != 0 {
                content.secondaryText = "-\n"+"\(client.phoneNumber)".applyPatternOnNumbers()
            } else if address != "" && client.phoneNumber == 0 {
                content.secondaryText = "\(address)\n-"
            } else {
                content.secondaryText = "\(address)\n"+"\(client.phoneNumber)".applyPatternOnNumbers()
            }
        }
        content.image = UIImage(systemName: "person.fill")
        content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        
        cell.contentConfiguration = content
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let clientToDelete = ClientController.shared.clients[indexPath.row]
            ClientController.shared.deleteClient(client: clientToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.handleEditClient(indexPath: indexPath)
            completionHandler(true)
        }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.handleDeleteClient(indexPath: indexPath)
            completionHandler(true)
        }
        edit.backgroundColor = .systemYellow
        delete.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return configuration
    }
    
    func handleDeleteClient(indexPath: IndexPath) {
        let clientToDelete = ClientController.shared.clients[indexPath.row]
        ClientController.shared.deleteClient(client: clientToDelete)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func handleEditClient(indexPath: IndexPath) {
        let sender = ClientController.shared.clients[indexPath.row]
        
        self.performSegue(withIdentifier: "toEditClient", sender: sender)
        
    }
    
//=============================================================================================================================
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let call = UIContextualAction(style: .normal, title: "Call") { [weak self] (action, view, completionHandler) in
            self?.handleCallClient(indexPath: indexPath)
            completionHandler(true)
        }
        let map = UIContextualAction(style: .destructive, title: "Map") { [weak self] (action, view, completionHandler) in
            self?.handleMapClient(indexPath: indexPath)
            completionHandler(true)
        }
        call.backgroundColor = .systemGreen
        map.backgroundColor = .systemBlue
        let configuration = UISwipeActionsConfiguration(actions: [call, map])
        
        return configuration
    }
    
    func handleCallClient(indexPath: IndexPath) {
        let phoneNumber = ClientController.shared.clients[indexPath.row].phoneNumber
        if phoneNumber == 0 {
            let alert = UIAlertController(title: "Missing Info", message: "Please enter a phone number for this client", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .default))
            present(alert, animated: true)
        } else {
            if let url = URL(string: "tel://\(phoneNumber)") {
                
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
                
                UIApplication.shared.open(url, options: [:]) { success in
                    if !success {
                        let alert = UIAlertController(title: "Unable to place call", message: "Ensure you are on a physical device that allows phone calls and not an Xcode simulator", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Got it!", style: .default))
                        DispatchQueue.main.async {
                            self.present(alert, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    func handleMapClient(indexPath: IndexPath) {
        if let address = ClientController.shared.clients[indexPath.row].address {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address) { (placemarks, error) in
                if let placemarks = placemarks?.first {
                    let location = placemarks.location?.coordinate ?? CLLocationCoordinate2D()
                    guard let url = URL(string:"http://maps.apple.com/?daddr=\(location.latitude),\(location.longitude)") else { return }
                    UIApplication.shared.open(url)
                } else {
                    let alert = UIAlertController(title: "Unable to find address", message: "Ensure address is a valid address", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Got it!", style: .default))
                    self.present(alert, animated: true)
                }
            }
        } else {
            let alert = UIAlertController(title: "Unable to find address", message: "Ensure address is a valid address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .default))
            present(alert, animated: true)
        }
    }
    
//=============================================================================================================================

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInvoicesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? InvoicesTVC
            else { return }
            let client = ClientController.shared.clients[indexPath.row]
            destination.client = client
        } else if segue.identifier == "toEditClient" {
            guard let destination = segue.destination as? NewClientVC
            else { return }
            let clientToEdit = sender
            destination.client = clientToEdit as? Client
            destination.isNewClient = false
        }
        
    }
} // end of class
