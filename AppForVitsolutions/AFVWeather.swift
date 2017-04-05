//
//  AFVWeather.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/4/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

struct AFVWeather {
    
    var id: String? = nil
    var bigImagePath: String? = nil
    var smallImagePath: String? = nil
    var created: String? = nil
    var longitude: Float? = nil
    var latitude: Float? = nil
    var weatherInfo: String? = nil
    
    init(with dictionary: Dictionary<String, Any>) {
            
        id = dictionary["id"] as? String
        bigImagePath = dictionary["bigImagePath"] as? String
        smallImagePath = dictionary["smallImagePath"] as? String
        created = dictionary["created"] as? String
            
        if let infoDictionary = dictionary["parameters"] as? [String: Any] {
            latitude = infoDictionary["latitude"] as? Float
            longitude = infoDictionary["longitude"] as? Float
            weatherInfo = infoDictionary["weather"] as? String
        }
    }    
}
