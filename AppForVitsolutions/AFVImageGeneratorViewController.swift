//
//  AFVImageGeneratorViewController.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import PKHUD

class AFVImageGeneratorViewController: UIViewController {

    @IBOutlet weak var generatedGIFImageView: UIImageView!
    
    private let applicationManager = AFVApplicationManager.instance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGeneratedGIF()
    }
    
    private func getGeneratedGIF()
    {
        HUD.show(.progress)
        applicationManager.apiService.getGIF { (result) in
            switch result {
            case .success(let value):
                HUD.flash(.success)
                guard let dictionary = value as? [String: Any], let stringLink = dictionary["gif"] as? String else { return }
                self.handleGIFpresentation(stringLink)
                print("Gif link \(value)")
            case .failure(let error):
                HUD.flash(.error)
                print(error)
            }
        }
    }
    
    private func handleGIFpresentation(_ withStringURL: String)
    {
        let imageURL = UIImage.gifImageWithURL(gifUrl: withStringURL)
        generatedGIFImageView.image = imageURL
    }

}
