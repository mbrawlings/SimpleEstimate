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
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var viewSeparatorLine: UIView!
    
    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        Styling.styleBackgroundFor(view: view, tableView: tableView)
        productView.backgroundColor = UIColor(red: 102/255, green: 162/255, blue: 186/255, alpha: 1.0)
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
    
    @IBAction func addProductButtonTapped(_ sender: Any) {
        guard let productName = productTextField.text,
              !productName.isEmpty,
              let productPrice = priceTextField.text,
              !productPrice.isEmpty
        else {
            present(Alert.error(message: "Product fields cannot be empty"), animated: true)
            return
        }
        if !isUpdating {
            if let price = Double(productPrice) {
                ProductController.shared.createProduct(productName: productName, price: price)
            } else {
                present(Alert.error(message: "Prices can only contain numbers"), animated: true)
            }
        } else if isUpdating {
            guard let productToEdit else { return }
            if let price = Double(productPrice) {
                ProductController.shared.editProduct(product: productToEdit, productName: productName, price: price)
                isUpdating = false
            } else {
                present(Alert.error(message: "Prices can only contain numbers"), animated: true)
            }
        }
        addProductButton.setTitle("Add Product", for: .normal)
        productTextField.text = ""
        priceTextField.text = ""
        productTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
        tableView.reloadData()
    }
    
    //MARK: - HELPER METHODS
    func setupView() {
        Styling.styleTextFieldWith(textField: productTextField)
        Styling.styleTextFieldWith(textField: priceTextField)
        Styling.styleLineBreakWith(view: viewSeparatorLine)
        Styling.styleButtonWith(button: addProductButton)
        
        ProductController.shared.fetchProducts()
    }
}

    //MARK: - TABLE VIEW METHODS
extension ProductsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ProductController.shared.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductTableCell else { return UITableViewCell() }
        
        let product = ProductController.shared.products[indexPath.row]
        cell.product = product
        
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
        let alert = UIAlertController(title: "Delete?", message: "This action cannot be undone", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            let productToDelete = ProductController.shared.products[indexPath.row]
            ProductController.shared.deleteProduct(product: productToDelete)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func handleEditProduct(indexPath: IndexPath) {
        isUpdating = true
        productTextField.text = ProductController.shared.products[indexPath.row].productName
        priceTextField.text = "\(ProductController.shared.products[indexPath.row].price)"
        productTextField.becomeFirstResponder()
        addProductButton.setTitle("Save Changes", for: .normal)
        self.productToEdit = ProductController.shared.products[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
