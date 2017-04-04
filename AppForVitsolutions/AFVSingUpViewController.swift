//
//  AFVSingUpViewController.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import PKHUD

class AFVSingUpViewController: AFVImagePickerViewController {
    
    enum SegueIdentifier: String {
        case mainScreen = "AFVSegueToMainScreen"
    }

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    private let applicationManager = AFVApplicationManager.instance()
    
    // MARK: - Main methods
    
    private func signUp()
    {
        guard let email = emailTextField.text, let password = passwordTextField.text, let userName = userNameTextField.text, let avatar = avatarImageView.image else {
            return
        }
        
        HUD.show(.progress)
        
        applicationManager.apiService.signUpUserWith(avatar, userName: userName, email: email, password: password) {(result) in
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
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        dismiss(animated: true, completion: { () -> Void in
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.avatarImageView.image = image
            } else {
                self.avatarImageView.image = #imageLiteral(resourceName: "icon_unisex")
            }
        })
    }
    
    // MARK: - Actions
    
    @IBAction func onPressedSignUpButton()
    {
        signUp()
    }
    
    @IBAction func onTappedAddAvatarButton(_ sender: Any)
    {
        showActionSheet()
    }
}
