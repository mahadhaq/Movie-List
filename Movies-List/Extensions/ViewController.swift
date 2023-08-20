//
//  ViewController.swift
//  Movies-List
//
//  Created by Mahad on 8/21/23.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        // Create an action for the OK button
        let okAction = UIAlertAction(title: "OK",style: .default,handler:nil)
        
        // Add the OK action to the alert controller
        alertController.addAction(okAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
}
