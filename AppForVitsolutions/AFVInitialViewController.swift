//
//  AFVInitialViewController.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

class AFVInitialViewController: UITableViewController {
    
    enum ReuseIdentifier: String {
        case avatarCell = "AFVAvatarViewCell"
        case inputFieldCell = "AFVInputFieldCell"
        case sendCredentialsCell = "AFVSendCredentialsCell"
    }
    
    enum InputFieldPlaceholder: String {
        case userName = "User Name"
        case email = "E-mail"
        case password = "Password"
    }
    
    enum SendCredentialsButtonTitle: String {
        case logIn = "Login"
        case signUp = "Sign Up"
    }
    
    enum IndexForCell {
        case avatarCell (Int) = 0
        case userNameCell (Int) = 1
        case emaileCell (Int) = 2
        case passwordCell (Int) = 3
        case userNameCell (Int) = 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
