//
//  AFVImagePickerManager.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/4/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

class AFVImagePickerViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showActionSheet()
    {
        let photoActionSheet = UIAlertController(title: "Choose image", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cameraButtonAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (UIAlertAction) in
            self.shootPhoto()
        }
        
        let galleryButtonAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default) { (UIAlertAction) in
            self.selectImageFromLibrary()
        }
        
        let cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (UIAlertAction) in
        }
        
        photoActionSheet.addAction(cameraButtonAction)
        photoActionSheet.addAction(galleryButtonAction)
        photoActionSheet.addAction(cancelButtonAction)
        
        present(photoActionSheet, animated: true, completion: nil)
    }
    
    fileprivate func selectImageFromLibrary()
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func shootPhoto()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .camera
            imagePickerController.cameraCaptureMode = .photo
            imagePickerController.modalPresentationStyle = .fullScreen
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    
    fileprivate func noCamera()
    {
        let noCameraAlertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        noCameraAlertVC.addAction(okAction)
        present(noCameraAlertVC, animated: true, completion: nil)
    }

}
