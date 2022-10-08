//
//  EditPriceViewController.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/8/22.
//

import UIKit

class EditPriceViewController: UIViewController {
    
    //MARK: - Properties
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
    var calculatedPrice: Double = 0.0
    var discountChosen: Double = 1.0
    
    
    
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
    }
    @IBAction func regularWindowStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        regularWindowAmount += sender.value
        regularWindowCount.text = "\(Int(regularWindowAmount))"
        sender.value = 0.0
    }
    @IBAction func smallWindowStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        smallWindowAmount += sender.value
        smallWindowCount.text = "\(Int(smallWindowAmount))"
        sender.value = 0.0
    }
    @IBAction func bigLadderStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        bigLadderAmount += sender.value
        bigLadderCount.text = "\(Int(bigLadderAmount))"
        sender.value = 0.0
    }
    @IBAction func smallLadderStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        smallLadderAmount += sender.value
        smallLadderCount.text = "\(Int(smallLadderAmount))"
        sender.value = 0.0
    }
    @IBAction func screenStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        screenAmount += sender.value
        screenCount.text = "\(Int(screenAmount))"
        sender.value = 0.0
    }
    @IBAction func hardWaterStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        hardWaterAmount += sender.value
        hardWaterCount.text = "\(Int(hardWaterAmount))"
        sender.value = 0.0
    }
    @IBAction func hardWaterSmallStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        hardWaterSmallAmount += sender.value
        hardWaterSmallCount.text = "\(Int(hardWaterSmallAmount))"
        sender.value = 0.0
    }
    @IBAction func constructionStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        bigWindowAmount += sender.value
        bigWindowCount.text = "\(Int(bigWindowAmount))"
        sender.value = 0.0
    }
    @IBAction func trackStepper(_ sender: UIStepper) {
        sender.maximumValue = 1.0
        sender.minimumValue = -1.0
        constructionAmount += sender.value
        constructionCount.text = "\(Int(constructionAmount))"
        sender.value = 0.0
    }
    @IBAction func discountControlAdjusted(_ sender: UISegmentedControl) {
    }
    @IBAction func saveChangesButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    //MARK: - Helper Functions
    func setupView() {
        guard let editPricing = self.editPricing else { return }
        bigWindowAmount = Double(editPricing.bigWindow)
        bigWindowCount.text = "\(Int(bigWindowAmount))"
        regularWindowAmount = Double(editPricing.regularWindow)
        regularWindowCount.text = "\(Int(regularWindowAmount))"
        smallWindowAmount = Double(editPricing.smallWindow)
        smallWindowCount.text = "\(Int(smallWindowAmount))"
        bigLadderAmount = Double(editPricing.bigLadder)
        bigLadderCount.text = "\(Int(bigLadderAmount))"
        smallLadderAmount = Double(editPricing.bigWindow)
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
        calculatedPrice = Double(editPricing.totalPrice)
        totalPriceLabel.text = "\(calculatedPrice)"
        discountChosen = Double(editPricing.discount)
        switch discountChosen {
        case 1.0:
            discountSegmentedControl.setEnabled(true, forSegmentAt: 0)
        case 0.9:
            discountSegmentedControl.setEnabled(true, forSegmentAt: 1)
        case 0.85:
            discountSegmentedControl.setEnabled(true, forSegmentAt: 2)
        case 0.8:
            discountSegmentedControl.setEnabled(true, forSegmentAt: 3)
        default:
            discountSegmentedControl.setEnabled(true, forSegmentAt: 0)
        }
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
