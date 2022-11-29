//
//  Alert.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 11/28/22.
//

import Foundation
import UIKit

class Alert {
    static func error(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it!", style: .default))
        return alert
    }
    static func unableToFindAddress() -> UIAlertController {
        let alert = UIAlertController(title: "Unable to find address", message: "Ensure address is a valid address", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it!", style: .default))
        return alert
    }
}
