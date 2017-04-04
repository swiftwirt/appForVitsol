//
//  AFVImageGeneratorViewController.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

class AFVImageGeneratorViewController: UIViewController {

    @IBOutlet weak var generatedGIFImageView: UIImageView!
    
    private let applicationManager = AFVApplicationManager.instance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func getgeneratedGIF()
    {
        applicationManager.apiService.getGIF { (result) in
            switch result {
            case .success(let value):
                print("Do smth with gif link \(value)")
            case .failure(let error):
                print(error)
            }
        }
    }

}
