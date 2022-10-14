//
//  WindowCountTableViewController.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import UIKit

class WindowCountTableViewController: UITableViewController {
    
    //MARK: - PROPERTIES
    var client: Client?
    var filteredWindowCounts: [WindowCount] = []

    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
        tableView.reloadData()
    }
    
    //MARK: - HELPER METHODS
    func setupView() {
        filteredWindowCounts = WindowCountController.shared.windowCounts.filter { eachWindowCount in
            eachWindowCount.client == self.client
        }
    }

    // MARK: - TABLE VIEW DATA SOURCE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredWindowCounts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "windowCountCell", for: indexPath)
        let windowCount = filteredWindowCounts[indexPath.row]
        
        guard let descriptionOfClean = windowCount.countDescription else { return cell }
        
        var content = cell.defaultContentConfiguration()
        
        content.text = "$\(windowCount.totalPrice)"
        content.secondaryText = "\(descriptionOfClean)"
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let windowCountToDelete = WindowCountController.shared.windowCounts[indexPath.row]
            WindowCountController.shared.deleteWindowCount(windowCount: windowCountToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */



    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddPriceVC" {
            guard let destination = segue.destination as? NewPriceViewController else { return }
            destination.client = self.client
        }
        
        if segue.identifier == "toEditPricingVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EditPriceViewController else { return }
            let itemToEdit = WindowCountController.shared.windowCounts[indexPath.row]
            destination.editPricing = itemToEdit
        }
    }

}
