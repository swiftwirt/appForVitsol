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
    
    // TODO: Add location manager here
    let latitude: Float = 49.993500
    let longitude: Float = 36.230383
    
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
        guard let picture = UIImage(named: "fun") else { return }
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
