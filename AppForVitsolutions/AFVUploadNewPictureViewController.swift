//
//  AFVUploadNewPictureViewController.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import PKHUD

class AFVUploadNewPictureViewController: UITableViewController {
    
    // MARK: - Constants
    let latitude: Float = 51.4826
    let longitude: Float = 0.0077
    
    @IBOutlet weak var uploadPictureImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var hashtagTextField: UITextField!
    
    let applicationManager = AFVApplicationManager.instance()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Main methods
    
    private func addImage()
    {
        guard let picture = uploadPictureImageView.image else { return }
        HUD.show(.progress)
        applicationManager.apiService.uploadNew(picture, description: descriptionTextField.description, hashtag: hashtagTextField.text, latitude: latitude, longitude: longitude) { (result) in
            switch(result) {
            case .success(let value):
                print(value)
                HUD.flash(.success, delay: 1.0)
            case .failure(let error):
                print(error)
                HUD.flash(.error, delay: 1.0)
            }
        }
    }

    // MARK: - Actions
    
    @IBAction func onPressedDoneButton(_ sender: Any)
    {
        addImage()
    }
}
