//
//  AFVUploadNewPictureViewController.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import PKHUD
import CoreLocation

class AFVUploadNewPictureViewController: AFVImagePickerViewController {
    
    @IBOutlet weak var uploadPictureImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var hashtagTextField: UITextField!
    
    let applicationManager = AFVApplicationManager.instance()
    
    var location: CLLocation?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getLocation()
    }
    
    // MARK: - Main methods
    
    private func getLocation()
    {
        applicationManager.locationService.locationServiceCoordinatesResult = { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let value):
                if let coordinates = value as? CLLocation {
                    strongSelf.location = coordinates
                } else {
                    print("***** Weird error occured! No CLLocation Data =(")
                    HUD.flash(.error)
                }
            case .failure(let error):
                if error != nil { print(error!) }
                HUD.flash(.error)
            }
        }
    }
    
    private func addImage()
    {
        guard let picture = uploadPictureImageView.image, let latitude = location?.coordinate.latitude, let longitude = location?.coordinate.longitude else { return }
        HUD.show(.progress)

        applicationManager.apiService.uploadNew(picture, description: descriptionTextField.description, hashtag: hashtagTextField.text, latitude: Float(latitude), longitude: Float(longitude)) { (result) in
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
    
    // MARK: - Alerts    
    
    fileprivate func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disabled",
                                      message: "Please enable location services for this app in Settings.",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
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

