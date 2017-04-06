//
//  AFVErrorHandler.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/6/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

class AFVErrorHandler {
    
    enum ErrorType: Error {
        case incorrectData // No email data
        case invalidUserData // No valid email/password data
        case unknownError // Error description does not found
    }
    
    enum KeyForError: String {
        case error = "error"
    }
    
    enum ErrorDescription: String {
        case incorrectData = "Incorrect data"
        case invalidUserData = "Invalid user data"
    }

    func handleRegistrationError(jsonDic: Dictionary<AnyHashable,Any>) throws
    {
        if let error = jsonDic[KeyForError.error.rawValue] as? String {
            switch error {
                case ErrorDescription.incorrectData.rawValue:
                    throw ErrorType.incorrectData
                case ErrorDescription.invalidUserData.rawValue:
                throw ErrorType.invalidUserData
                default:
                    throw ErrorType.unknownError
            }
            
        }
    }
}
