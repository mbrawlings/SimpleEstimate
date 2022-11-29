//
//  ClientsTVC.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import UIKit
import CoreLocation

class ClientsTVC: UITableViewController {
    
    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        Styling.styleNavigationTitle(navigationController: navigationController)
        Styling.styleBackgroundFor(view: view, tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ClientController.shared.fetchClients()
        tableView.reloadData()
    }

    // MARK: - TABLE VIEW METHODS
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClientController.shared.clients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "clientCell", for: indexPath) as? ClientTableCell else { return UITableViewCell() }

        let client = ClientController.shared.clients[indexPath.row]
        
        cell.client = client
        
        return cell
    }
    
    //MARK: - TRAILING SWIPE ACTIONS
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completionHandler) in
            self?.handleEditClient(indexPath: indexPath)
            completionHandler(true)
        }
        
        let delete = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            self?.handleDeleteClient(indexPath: indexPath)
            completionHandler(true)
        }
        edit.image = UIImage(systemName: "pencil")
        edit.backgroundColor = .systemYellow
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return configuration
    }
    
    func handleDeleteClient(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete?", message: "This action cannot be undone", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            let clientToDelete = ClientController.shared.clients[indexPath.row]
            ClientController.shared.deleteClient(client: clientToDelete)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func handleEditClient(indexPath: IndexPath) {
        let sender = ClientController.shared.clients[indexPath.row]
        
        self.performSegue(withIdentifier: "toEditClient", sender: sender)
    }
    
    //MARK: - LEADING SWIPE ACTIONS
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let call = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completionHandler) in
            self?.handleCallClient(indexPath: indexPath)
            completionHandler(true)
        }
        let map = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            self?.handleMapClient(indexPath: indexPath)
            completionHandler(true)
        }
        call.image = UIImage(systemName: "phone")
        call.backgroundColor = .systemGreen
        map.image = UIImage(systemName: "map")
        map.backgroundColor = .systemBlue
        let configuration = UISwipeActionsConfiguration(actions: [call, map])
        
        return configuration
    }
    
    //MARK: - CALLING
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
    
    //MARK: - MAPPING
    func handleMapClient(indexPath: IndexPath) {
        if let street = ClientController.shared.clients[indexPath.row].streetAddress,
           let city = ClientController.shared.clients[indexPath.row].cityAddress,
           let state = ClientController.shared.clients[indexPath.row].stateAddress {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString("\(street) \(city) \(state)") { (placemarks, error) in
                if let placemarks = placemarks?.first {
                    let location = placemarks.location?.coordinate ?? CLLocationCoordinate2D()
                    
                    let mapsAlert = UIAlertController(title: "Open in...", message: nil, preferredStyle: .actionSheet)
                    let googleMapsAction = UIAlertAction(title: "Google Maps", style: .default) { action in
                        guard let url = URL(string:"comgooglemaps://?saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=driving") else { return }
                        UIApplication.shared.open(url)
                    }
                    let appleMapsAction = UIAlertAction(title: "Apple Maps", style: .default) { action in
                        guard let url = URL(string:"http://maps.apple.com/?daddr=\(location.latitude),\(location.longitude)") else { return }
                        UIApplication.shared.open(url)
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    mapsAlert.addAction(googleMapsAction)
                    mapsAlert.addAction(appleMapsAction)
                    mapsAlert.addAction(cancelAction)
                    self.present(mapsAlert, animated: true)
                    
                } else {
                    self.present(Alert.unableToFindAddress(), animated: true)
                }
            }
        } else {
            present(Alert.unableToFindAddress(), animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    //MARK: - NAVIGATION
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
