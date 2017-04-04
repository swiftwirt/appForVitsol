//
//  AFVUploadNewPictureViewController.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import PKHUD

class AFVUploadNewPictureViewController: AFVImagePickerViewController {
    
    // TODO: Add location manager here
    let latitude: Float = 49.993500
    let longitude: Float = 36.230383
    
    @IBOutlet weak var uploadPictureImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var hashtagTextField: UITextField!
    
    let applicationManager = AFVApplicationManager.instance()
    
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
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        dismiss(animated: true, completion: { () -> Void in
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.uploadPictureImageView.image = image
            } else {
                self.uploadPictureImageView.image = #imageLiteral(resourceName: "icon_add_image")
            }
        })
    }

    // MARK: - Actions
    @IBAction func onTappedPickUpImage(_ sender: Any)
    {
        showActionSheet()
    }
    
    @IBAction func onPressedDoneButton(_ sender: Any)
    {
        addImage()        
    }
}

