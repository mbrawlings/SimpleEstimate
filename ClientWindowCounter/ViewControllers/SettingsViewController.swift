//
//  SettingsViewController.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/17/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: PROPERTIES
    
    //MARK: - OUTLETS
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var price1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var price2: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var price3: UITextField!
    @IBOutlet weak var text4: UITextField!
    @IBOutlet weak var price4: UITextField!
    @IBOutlet weak var text5: UITextField!
    @IBOutlet weak var price5: UITextField!
    @IBOutlet weak var text6: UITextField!
    @IBOutlet weak var price6: UITextField!
    @IBOutlet weak var text7: UITextField!
    @IBOutlet weak var price7: UITextField!
    @IBOutlet weak var text8: UITextField!
    @IBOutlet weak var price8: UITextField!
    @IBOutlet weak var text9: UITextField!
    @IBOutlet weak var price9: UITextField!
    @IBOutlet weak var text10: UITextField!
    @IBOutlet weak var price10: UITextField!
    
    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - ACTION
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
//        ProductController.shared.updateProducts(text: <#T##String#>, price: <#T##Double#>, amount: <#T##Int#>)
//        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - HELPER METHODS
    func setupView() {
        ProductController.shared.fetchProducts()
//        print(ProductController.shared.products)
    }
}
