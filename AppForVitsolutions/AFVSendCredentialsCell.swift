//
//  AFVSendCredentialsCell.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

class AFVSendCredentialsCell: UITableViewCell {

    @IBOutlet weak var credentialsButton: UIButton!
    
    var closure: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onPressedSendCredentialsButton(_ sender: UIButton!)
    {
        guard let aClosure = closure() else { return }
        aClosure()
    }
}
