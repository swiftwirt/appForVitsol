//
//  AFVRestApiService.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import Foundation
import Alamofire

class AFVRestApiService {
    
    enum EndPoint: String {
        case baseUrl = "http://api.doitserver.in.ua/api/"
        case create = "create"
        case login = "login"
        case getAll = "all"
        case getGIF = "gif"
        case uploadImage = "image"
    }
    
    enum JSONKey: String {
        case email = "email"
        case userName = "username"
        case password = "password"
        case avatar = "avatar"
        case weather = "weather"
        case image = "image"
        case description = "description"
        case hashtag = "hashtag"
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
    let keychainService = AFVKeychainService()
    
    func saveToken(token: String)
    {
        keychainService.saveToken(token: token)
    }
    
    func createUserWith(_ avatar: UIImage, userName: String, email: String, password: String, completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        let parameters: Parameters = [
            JSONKey.email.rawValue: email,
            JSONKey.userName.rawValue: userName,
            JSONKey.password.rawValue: password,
            JSONKey.avatar.rawValue: avatar
        ]
        
        let url = EndPoint.baseUrl.rawValue + EndPoint.create.rawValue
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for param in parameters {
                if let value = param.value as? String {
                    multipartFormData.append(value.data(using: .utf8)!, withName: param.key)
                }
            }
            
            if let mediaData = UIImagePNGRepresentation(avatar) {
                multipartFormData.append(mediaData, withName: "avatar", fileName: "1", mimeType: "image/png")
            }
            
        }, to: url, method: .post , headers: nil, encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print(progress.fractionCompleted * 100)
                })
                
                upload.responseJSON(completionHandler: { (response) in
                    completionHandler(APIResult.success(response))
                })
            case .failure(let error):
                print(error)
                
            }
        })
    }
    
    func loginUserWith(_ email: String, password: String, completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        let parameters: Parameters = [
            JSONKey.email.rawValue: email,
            JSONKey.password.rawValue: password
        ]
        
        let url = EndPoint.baseUrl.rawValue + EndPoint.login.rawValue
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let value):
                if let dictionary = value as? [String: Any],
                    let token = dictionary["token"] as? String {
                    self.saveToken(token: token)
                }
                completionHandler(APIResult.success(value))
            case .failure(let error):
                completionHandler(APIResult.failure(error))
            }
        }
    }

    func getAll(_ completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + keychainService.getToken(),
            "Accept": "application/json"
        ]
        
        let url = EndPoint.baseUrl.rawValue + EndPoint.getAll.rawValue
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response: DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let value):
                completionHandler(APIResult.success(value))
            case .failure(let error):
                completionHandler(APIResult.failure(error))
            }
        }
    }
    
    func getGIF(_ completionHandler: @escaping (APIResult<Any>) -> Void)
    {        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + keychainService.getToken(),
            "Accept": "application/json"
        ]
        
        let url = EndPoint.baseUrl.rawValue + EndPoint.getGIF.rawValue
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response: DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let value):
                completionHandler(APIResult.success(value))
            case .failure(let error):
                completionHandler(APIResult.failure(error))
            }
        }
    }
    
    func uploadNew(_ image: UIImage, description: String?, hashtag: String?, latitude: Float, longitude: Float, completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        let parameters: Parameters = [
            JSONKey.image.rawValue: image,
            JSONKey.description.rawValue: description ?? "",
            JSONKey.hashtag.rawValue: hashtag ?? "",
            JSONKey.latitude.rawValue: String(latitude),
            JSONKey.longitude.rawValue: String(longitude),
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + keychainService.getToken(),
            "Accept": "application/json"
        ]
        
        let url = EndPoint.baseUrl.rawValue + EndPoint.uploadImage.rawValue
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for param in parameters {
                if let value = param.value as? String {
                    multipartFormData.append(value.data(using: .utf8)!, withName: param.key)
                }
            }
            
            if let mediaData = UIImagePNGRepresentation(image) {
                multipartFormData.append(mediaData, withName: "image", fileName: "1", mimeType: "image/png")
            }
            
        }, to: url, method: .post , headers: headers, encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print(progress.fractionCompleted * 100)
                })
                
                upload.responseJSON(completionHandler: { (response) in
                    completionHandler(APIResult.success(response))
                })
            case .failure(let error):
                print(error)
                
            }
        })
    }
}
