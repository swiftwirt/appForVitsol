//
//  AFVAlertHandler.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/8/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

class AFVAlertHandler {
    // Set this property to self in targeting view controller!
    weak var viewController: UIViewController?
    
    func showIncorectDataError() {
        showAlert(title: "Empty Credentials!!!", message: "Please, fill in all required fields!")
    }
    
    func showInvalidUserDataError() {
       showAlert(title: "Invalid Credentials!!!", message: "Please, check your email or password!")
    }
    
    func showNoPasswordError() {
        showAlert(title: "Invalid Credentials!!!", message: "Please, fill in your password!")
    }
    
    func showNoEmailError() {
        showAlert(title: "Invalid Credentials!!!", message: "Please, enter email!")
    }
    
    func showNoValidEmailError() {
        showAlert(title: "Invalid Credentials!!!", message: "Please, enter valid email!")
    }
    
    func showUnknownError() {
        showAlert(title: "Unknown Error!", message: "Something went wrong, but we don't know what!")
    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.cancel, handler: { _ in
            completion?()
        }))
        viewController?.present(alert, animated: true, completion: nil)
    }
    
}
