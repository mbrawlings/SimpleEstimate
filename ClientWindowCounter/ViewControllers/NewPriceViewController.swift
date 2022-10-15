//
//  NewPriceViewController.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import UIKit

class NewPriceViewController: UIViewController {
    
    //MARK: - Properties
    var client: Client?
    
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
    var discountChosen: Double = 1.0

    //MARK: - Outlets
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
    @IBOutlet weak var descriptionCountTextField: UITextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    func stepperCalculator(sender: UIStepper, aspectAmount: inout Double, label: UILabel) {
//        sender.maximumValue = Double.infinity
//        aspectAmount = sender.value
//        label.text = "\(Int(aspectAmount))"
//        calculateTotal()
//    }
    
    //MARK: - Action
    @IBAction func bigWindowStepper(_ sender: UIStepper) {
//        stepperCalculator(sender: sender, aspectAmount: &bigWindowAmount, label: bigWindowCount)
        
        sender.maximumValue = Double.infinity
        bigWindowAmount = sender.value
        bigWindowCount.text = "\(Int(bigWindowAmount))"
        calculateTotal()
    }
    @IBAction func regularWindowStepper(_ sender: UIStepper) {
        sender.maximumValue = Double.infinity
        regularWindowAmount = sender.value
        regularWindowCount.text = "\(Int(regularWindowAmount))"
        calculateTotal()
    }
    @IBAction func smallWindowStepper(_ sender: UIStepper) {
        sender.maximumValue = Double.infinity
        smallWindowAmount = sender.value
        smallWindowCount.text = "\(Int(smallWindowAmount))"
        calculateTotal()
    }
    @IBAction func bigLadderStepper(_ sender: UIStepper) {
        sender.maximumValue = Double.infinity
        bigLadderAmount = sender.value
        bigLadderCount.text = "\(Int(bigLadderAmount))"
        calculateTotal()
    }
    @IBAction func smallLadderStepper(_ sender: UIStepper) {
        sender.maximumValue = Double.infinity
        smallLadderAmount = sender.value
        smallLadderCount.text = "\(Int(smallLadderAmount))"
        calculateTotal()
    }
    @IBAction func screenStepper(_ sender: UIStepper) {
        sender.maximumValue = Double.infinity
        screenAmount = sender.value
        screenCount.text = "\(Int(screenAmount))"
        calculateTotal()
    }
    @IBAction func hardWaterStepper(_ sender: UIStepper) {
        sender.maximumValue = Double.infinity
        hardWaterAmount = sender.value
        hardWaterCount.text = "\(Int(hardWaterAmount))"
        calculateTotal()
    }
    @IBAction func hardWaterSmallStepper(_ sender: UIStepper) {
        sender.maximumValue = Double.infinity
        hardWaterSmallAmount = sender.value
        hardWaterSmallCount.text = "\(Int(hardWaterSmallAmount))"
        calculateTotal()
    }
    @IBAction func constructionStepper(_ sender: UIStepper) {
        sender.maximumValue = Double.infinity
        constructionAmount = sender.value
        constructionCount.text = "\(Int(constructionAmount))"
        calculateTotal()
    }
    @IBAction func trackStepper(_ sender: UIStepper) {
        sender.maximumValue = Double.infinity
        trackAmount = sender.value
        trackCount.text = "\(Int(trackAmount))"
        calculateTotal()
    }
    @IBAction func discountControlAdjusted(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
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
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard let descriptionCount = descriptionCountTextField.text,
              let client = client
        else { return }
        WindowCountController.shared.createWindowCount(countDescription: descriptionCount, bigWindow: Int(bigWindowAmount), regularWindow: Int(regularWindowAmount), smallWindow: Int(smallWindowAmount), smallLadder: Int(smallLadderAmount), bigLadder: Int(bigLadderAmount), hardWater: Int(hardWaterAmount), screen: Int(screenAmount), hardWaterSmall: Int(hardWaterSmallAmount), construction: Int(constructionAmount), track: Int(trackAmount), discount: discountChosen, totalPrice: calculatedPrice, client: client)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helper Functions
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
