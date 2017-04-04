//
//  AFVWeatherViewCell.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/4/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import SDWebImage

class AFVWeatherViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherTextLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var weather: AFVWeather! {
        didSet {
            if let path = weather.smallImagePath, let url = URL(string: path) {
                weatherImageView.sd_setImage(with: url)
            }
            weatherTextLabel.text = weather.weatherInfo
            addressLabel.text = "lat:\(weather.latitude), long: \(weather.longitude)"
        }
    }
}
