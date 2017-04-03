//
//  AFVInitialViewController.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import PKHUD

class AFVInitialViewController: UITableViewController {
    
    enum SegueIdentifier: String {
        case mainScreen = "AFVSegueToMainScreen"
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let applicationManager = AFVApplicationManager.instance()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Main methods
    
    private func logIn()
    {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        HUD.show(.progress)
        applicationManager.apiService.loginUserWith(email, password: password) { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let value):
                    print(value)
                    HUD.flash(.success, delay: 1.0)
                    self.performSegue(withIdentifier: SegueIdentifier.mainScreen.rawValue, sender: nil)
                case .failure(let error):
                    print(error)
                    HUD.flash(.error, delay: 1.0)
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func onPressedLogInButton()
    {
        logIn()
    }
}
