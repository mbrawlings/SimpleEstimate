//
//  ClientsTableViewController.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import UIKit

class ClientsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClientController.shared.clients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientCell", for: indexPath)

        let client = ClientController.shared.clients[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = client.name
        content.secondaryText = client.address
        
        
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWindowCountVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? WindowCountTableViewController
            else { return }
            let client = ClientController.shared.clients[indexPath.row]
            destination.client = client
        }
    }


}
