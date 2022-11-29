//
//  Styling.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 11/28/22.
//

import Foundation
import UIKit

class Styling {
    static func styleNavigationTitle(navigationController: UINavigationController?) {
        if UIScreen.main.bounds.height > 700.0 {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    static func styleCellWith(view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 1.0
        view.layer.masksToBounds = false
    }
    static func styleTextFieldWith(textField: UITextField) {
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10.0
        textField.layer.masksToBounds = true
    }
    static func styleButtonWith(button: UIButton) {
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10.0
        button.layer.masksToBounds = true
    }
    static func styleLineBreakWith(view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
    }
    static func styleBackgroundFor(view: UIView, tableView: UITableView?) {
        view.backgroundColor = UIColor(red: 102/255, green: 162/255, blue: 186/255, alpha: 1.0)
        tableView?.backgroundColor = UIColor(red: 102/255, green: 162/255, blue: 186/255, alpha: 1.0)
        tableView?.separatorStyle = .none
    }
}
