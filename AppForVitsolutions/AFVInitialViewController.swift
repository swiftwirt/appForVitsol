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
        // Configure ErrorHandler
        applicationManager.alertHandler.viewController = self
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
                    guard let dictionary = value as? [AnyHashable: Any] else {
                        HUD.flash(.error, delay: 1.0)
                        return
                    }
                    self.handleLogInError(dictionary)
                case .failure(let error):
                    print(error)
                    HUD.flash(.error, delay: 1.0)
                }
            }
        }
    }
    
    private func handleLogInError(_ dictionary: [AnyHashable: Any])
    {
        do {
            try self.applicationManager.errorHandler.handleLogInError(jsonDic: dictionary)
            HUD.flash(.success, delay: 1.0)
            self.performSegue(withIdentifier: SegueIdentifier.mainScreen.rawValue, sender: nil)
        } catch ErrorType.incorrectData {
            applicationManager.alertHandler.showIncorectDataError()
        } catch ErrorType.invalidUserData {
            applicationManager.alertHandler.showInvalidUserDataError()
        }  catch {
            applicationManager.alertHandler.showUnknownError()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func onPressedLogInButton()
    {
        logIn()
    }
}
