//
//  AlertViewClass.swift
//  demoLogin1
//
//  Created by Quang Dat on 4/14/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

class AlertViewClass: NSObject {
    static let staticAlertView = AlertViewClass()
    /**
     show alertView
     
     - parameter title:      title of Alert
     - parameter message:    message whant to show
     - parameter actions:     button in AlertView
     */
    func showAlert(_ title: String?, message: String?,actions:[UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil)
        }
        
    }

}

