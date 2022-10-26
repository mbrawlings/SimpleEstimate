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
    var productToEdit: Product?
    
    //MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var addProductButton: UIButton!
    
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
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        productTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
    }
    
    @IBAction func addProductButtonTapped(_ sender: UIButton) {
        guard let productName = productTextField.text,
              !productName.isEmpty,
              let productPrice = priceTextField.text,
              !productPrice.isEmpty
        else {
            let alert = UIAlertController(title: "Error", message: "Product fields cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .default))
            present(alert, animated: true)
            return
        }
        if !isUpdating {
            if let price = Double(productPrice) {
                ProductController.shared.createProduct(productName: productName, price: price)
            } else {
                let alert = UIAlertController(title: "Error", message: "Prices can only contain numbers", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Got it!", style: .default))
                present(alert, animated: true)
            }
        } else if isUpdating {
            guard let productToEdit else { return }
            if let price = Double(productPrice) {
                ProductController.shared.editProduct(product: productToEdit, productName: productName, price: price)
                isUpdating = false
            } else {
                let alert = UIAlertController(title: "Error", message: "Prices can only contain numbers", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Got it!", style: .default))
                present(alert, animated: true)
            }
        }
        addProductButton.setImage(UIImage(systemName: "plus"), for: .normal)
        productTextField.text = ""
        priceTextField.text = ""
        priceTextField.resignFirstResponder()
        tableView.reloadData()
    }
    
    //MARK: - HELPER METHODS
    func setupView() {
        productTextField.layer.borderWidth = 0.5
        productTextField.layer.cornerRadius = 10.0
        productTextField.layer.masksToBounds = true
        
        priceTextField.layer.borderWidth = 0.5
        priceTextField.layer.cornerRadius = 10.0
        priceTextField.layer.masksToBounds = true
        
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
        content.secondaryText = String(format: "$%.2f", product.price)

        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.handleEditProduct(indexPath: indexPath)
            completionHandler(true)
        }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.handleDeleteProduct(indexPath: indexPath)
            completionHandler(true)
        }
        edit.image = UIImage(systemName: "pencil")
        edit.backgroundColor = .systemYellow
        delete.image = UIImage(systemName: "trash")
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
        isUpdating = true
        productTextField.text = ProductController.shared.products[indexPath.row].productName
        priceTextField.text = "\(ProductController.shared.products[indexPath.row].price)"
        addProductButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        self.productToEdit = ProductController.shared.products[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
} // end of class

extension ProductsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        productTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
        return true
    }
}
