//
//  AFVApplicationManager.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

class AFVApplicationManager {

    static func instance() -> AFVApplicationManager
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        return appDelegate.applicationManager
    }
    
    lazy var apiService: AFVApiService = {
        
        let service = AFVApiService()
        
        return service
        
    }()
    
    lazy var locationService: AFVLocationService = {
        
        let service = AFVLocationService()
        
        return service
        
    }()
    
    lazy var errorHandler: AFVErrorHandler = {
        
        let errorHandler = AFVErrorHandler()
        
        return errorHandler
        
    }()
    
    lazy var alertHandler: AFVAlertHandler = {
        
        let alertHandler = AFVAlertHandler()
        
        return alertHandler
        
    }()
}
