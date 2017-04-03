//
//  AFVApiService.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

enum APIResult<T>
{
    case success(T)
    case failure(Error)
}

class AFVApiService {
    
    let restAPIService = AFVRestApiService()
    
    func signUpUserWith(_ avatar: UIImage, userName: String, email: String, password: String, completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        restAPIService.createUserWith(avatar, userName: userName, email: email, password: password, completionHandler: completionHandler)
    }
    
    func loginUserWith(_ email: String, password: String, completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        restAPIService.loginUserWith(email, password: password, completionHandler: completionHandler)
    }
    
    func getAll(_ completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        restAPIService.getAll(completionHandler)
    }
    
    func getGIF(_ completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        restAPIService.getGIF(completionHandler)
    }
    
    func uploadNew(_ image: UIImage, description: String?, hashtag: String?, latitude: Float, longitude: Float, completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        restAPIService.uploadNew(image, description: description, hashtag: hashtag, latitude: latitude, longitude: longitude, completionHandler: completionHandler)
    }
}
