//
//  EditPriceViewController.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/8/22.
//

import UIKit

class EditPriceViewController: UIViewController {
    
    //MARK: - Properties
    var client: Client?
    var editPricing: WindowCount?
        
    var bigWindowAmount: Double = 0.0
    var regularWindowAmount: Double = 0.0
    var smallWindowAmount: Double = 0.0
    var bigLadderAmount: Double = 0.0
    var smallLadderAmount: Double = 0.0
    var screenAmount: Double = 0.0
    var hardWaterAmount: Double = 0.0
    var hardWaterSmallAmount: Double = 0.0
    var constructionAmount: Double = 0.0
    var trackAmount: Double = 0.0
    var calculatedPrice: String = "$0.00"
    var discountChosen: Double = 0.0
    
    
    
    //MARK: - Outlets
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var bigWindowCount: UILabel!
    @IBOutlet weak var regularWindowCount: UILabel!
    @IBOutlet weak var smallWindowCount: UILabel!
    @IBOutlet weak var bigLadderCount: UILabel!
    @IBOutlet weak var smallLadderCount: UILabel!
    @IBOutlet weak var screenCount: UILabel!
    @IBOutlet weak var hardWaterCount: UILabel!
    @IBOutlet weak var hardWaterSmallCount: UILabel!
    @IBOutlet weak var constructionCount: UILabel!
    @IBOutlet weak var trackCount: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var discountSegmentedControl: UISegmentedControl!
    
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Action
    @IBAction func bigWindowStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        bigWindowAmount += sender.value
        bigWindowCount.text = "\(Int(bigWindowAmount))"
        sender.value = 0.0
        calculateTotal()
    }
    @IBAction func regularWindowStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        regularWindowAmount += sender.value
        regularWindowCount.text = "\(Int(regularWindowAmount))"
        sender.value = 0.0
        calculateTotal()
    }
    @IBAction func smallWindowStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        smallWindowAmount += sender.value
        smallWindowCount.text = "\(Int(smallWindowAmount))"
        sender.value = 0.0
        calculateTotal()
    }
    @IBAction func bigLadderStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        bigLadderAmount += sender.value
        bigLadderCount.text = "\(Int(bigLadderAmount))"
        sender.value = 0.0
        calculateTotal()
    }
    @IBAction func smallLadderStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        smallLadderAmount += sender.value
        smallLadderCount.text = "\(Int(smallLadderAmount))"
        sender.value = 0.0
        calculateTotal()
    }
    @IBAction func screenStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        screenAmount += sender.value
        screenCount.text = "\(Int(screenAmount))"
        sender.value = 0.0
        calculateTotal()
    }
    @IBAction func hardWaterStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        hardWaterAmount += sender.value
        hardWaterCount.text = "\(Int(hardWaterAmount))"
        sender.value = 0.0
        calculateTotal()
    }
    @IBAction func hardWaterSmallStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        hardWaterSmallAmount += sender.value
        hardWaterSmallCount.text = "\(Int(hardWaterSmallAmount))"
        sender.value = 0.0
        calculateTotal()
    }
    @IBAction func constructionStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        bigWindowAmount += sender.value
        bigWindowCount.text = "\(Int(bigWindowAmount))"
        sender.value = 0.0
        calculateTotal()
    }
    @IBAction func trackStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        constructionAmount += sender.value
        constructionCount.text = "\(Int(constructionAmount))"
        sender.value = 0.0
        calculateTotal()
    }
    @IBAction func discountControlAdjusted(_ sender: UISegmentedControl) {
        switch discountSegmentedControl.selectedSegmentIndex {
        case 0:
            discountChosen = 1.0
        case 1:
            discountChosen = 0.9
        case 2:
            discountChosen = 0.85
        case 3:
            discountChosen = 0.8
        default:
            discountChosen = 1.0
        }
        calculateTotal()


    }
    @IBAction func saveChangesButtonTapped(_ sender: UIBarButtonItem) {
        guard let descriptionCount = descriptionTextField.text,
              let client = client,
              let oldWindowCount = editPricing
        else { return }
        WindowCountController.shared.createWindowCount(countDescription: descriptionCount, bigWindow: Int(bigWindowAmount), regularWindow: Int(regularWindowAmount), smallWindow: Int(smallWindowAmount), smallLadder: Int(smallLadderAmount), bigLadder: Int(bigLadderAmount), hardWater: Int(hardWaterAmount), screen: Int(screenAmount), hardWaterSmall: Int(hardWaterSmallAmount), construction: Int(constructionAmount), track: Int(trackAmount), discount: discountChosen, totalPrice: calculatedPrice, client: client)
        WindowCountController.shared.deleteWindowCount(windowCount: oldWindowCount)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helper Functions
    func setupView() {
        guard let editPricing = self.editPricing,
              let totalPrice = editPricing.totalPrice
        else { return }
        descriptionTextField.text = editPricing.countDescription
        bigWindowAmount = Double(editPricing.bigWindow)
        bigWindowCount.text = "\(Int(bigWindowAmount))"
        regularWindowAmount = Double(editPricing.regularWindow)
        regularWindowCount.text = "\(Int(regularWindowAmount))"
        smallWindowAmount = Double(editPricing.smallWindow)
        smallWindowCount.text = "\(Int(smallWindowAmount))"
        bigLadderAmount = Double(editPricing.bigLadder)
        bigLadderCount.text = "\(Int(bigLadderAmount))"
        smallLadderAmount = Double(editPricing.smallLadder)
        smallLadderCount.text = "\(Int(smallLadderAmount))"
        screenAmount = Double(editPricing.screen)
        screenCount.text = "\(Int(screenAmount))"
        hardWaterAmount = Double(editPricing.hardWater)
        hardWaterCount.text = "\(Int(hardWaterAmount))"
        hardWaterSmallAmount = Double(editPricing.hardWaterSmall)
        hardWaterSmallCount.text = "\(Int(hardWaterSmallAmount))"
        constructionAmount = Double(editPricing.construction)
        constructionCount.text = "\(Int(constructionAmount))"
        trackAmount = Double(editPricing.track)
        trackCount.text = "\(Int(trackAmount))"
        calculatedPrice = totalPrice
        totalPriceLabel.text = calculatedPrice
        discountChosen = Double(editPricing.discount)
        switch discountChosen {
        case 1.0:
            discountSegmentedControl.selectedSegmentIndex = 0
        case 0.9:
            discountSegmentedControl.selectedSegmentIndex = 1
        case 0.85:
            discountSegmentedControl.selectedSegmentIndex = 2
        case 0.8:
            discountSegmentedControl.selectedSegmentIndex = 3
        default:
            discountSegmentedControl.selectedSegmentIndex = 0
        }
    }
    
    func calculateTotal() {
        let calculations: Double = (bigWindowAmount*5.0 + regularWindowAmount*2.0 + smallWindowAmount + smallLadderAmount/2 + bigLadderAmount + hardWaterAmount + hardWaterSmallAmount*0.35 + constructionAmount + screenAmount/2 + trackAmount/2) * discountChosen
        calculatedPrice = String(format: "$%.2f", calculations)
        totalPriceLabel.text = calculatedPrice
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
