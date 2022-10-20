//
//  ProductsVC.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/17/22.
//

import UIKit

class ProductsVC: UIViewController {
    
    //MARK: PROPERTIES
    var productCells = 0
    var isUpdating = false
    
    //MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupView()
    }
    
    //MARK: - ACTION
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addProductButtonTapped(_ sender: UIButton) {
        if !isUpdating {
            guard let productName = productTextField.text,
                  !productName.isEmpty,
                  let productPrice = priceTextField.text,
                  !productPrice.isEmpty
            else { return } // add alert if either is empty
            if let price = Double(productPrice) {
                ProductController.shared.createProduct(productName: productName, price: price)
            } else {
                // alert that price must be numbers
            }
            productTextField.text = ""
            priceTextField.text = ""
            tableView.reloadData()
        }
    }
    
    
    //MARK: - HELPER METHODS
    func setupView() {
        ProductController.shared.fetchProducts()
    }
}

    //MARK: - TABLE VIEW
extension ProductsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ProductController.shared.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        
        let product = ProductController.shared.products[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = product.productName
        content.secondaryText = "\(product.price)"

        cell.contentConfiguration = content
        
        return cell
    }

    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let productToDelete = ProductController.shared.products[indexPath.row]
//            ProductController.shared.deleteProduct(product: productToDelete)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.handleEditProduct(indexPath: indexPath)
            completionHandler(true)
        }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.handleDeleteProduct(indexPath: indexPath)
            completionHandler(true)
        }
        edit.backgroundColor = .systemYellow
        delete.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return configuration
    }
    
    func handleDeleteProduct(indexPath: IndexPath) {
        let productToDelete = ProductController.shared.products[indexPath.row]
        ProductController.shared.deleteProduct(product: productToDelete)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func handleEditProduct(indexPath: IndexPath) {
        productTextField.text = ProductController.shared.products[indexPath.row].productName
        priceTextField.text = "\(ProductController.shared.products[indexPath.row].price)"
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
} // end of class

