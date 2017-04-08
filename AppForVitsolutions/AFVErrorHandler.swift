//
//  AFVErrorHandler.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/6/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import PKHUD

enum ErrorType: Error {
    case incorrectData // No email data
    case invalidUserData // No valid email/password data
    case noAvatar // Empty avatar
    case noEmail // Empty email
    case invalidEmail // Email adress did not pass back-end validation
    case noPassword // Empty password field
    case unknownError // Error description does not found
}

class AFVErrorHandler {
    
    enum KeyForError: String {
        case error = "error"
        case errors = "children"
    }
    
    enum ErrorDescription: String {
        case incorrectData = "Incorrect data"
        case invalidUserData = "Invalid user data"
        case blankField = "This value should not be blank."
        case invalidEmail = "This value is not a valid email address."
    }

    func handleLogInError(jsonDic: Dictionary<AnyHashable,Any>) throws
    {
        if let error = jsonDic[KeyForError.error.rawValue] as? String {
            switch error {
                case ErrorDescription.incorrectData.rawValue:
                    HUD.flash(.error)
                    throw ErrorType.incorrectData
                case ErrorDescription.invalidUserData.rawValue:
                    HUD.flash(.error)
                    throw ErrorType.invalidUserData
                default:
                    HUD.flash(.error)
                    throw ErrorType.unknownError
            }
        }
    }
    
    func handleSignInError(jsonDic: Dictionary<AnyHashable,Any>) throws
    {
        if let errors = jsonDic[KeyForError.errors.rawValue] as? [String: Any] {

                if let _ = errors["avatar"] as? [String: Any] {
                    // Add for future case if back-end consider to replace this field as non-optional including cases for ErrorType
                }
                
                if let error = errors["email"] as? [String: Any] {
                    if let error = error["errors"] as? [String], error.first != nil {
                        switch error.first! {
                        case ErrorDescription.invalidEmail.rawValue:
                            HUD.flash(.error)
                            throw ErrorType.invalidEmail
                        case ErrorDescription.blankField.rawValue:
                            HUD.flash(.error)
                            throw ErrorType.noEmail
                        default: throw ErrorType.unknownError
                        }
                    }
                }
                
                if let error = errors["password"] as? [String: Any] {
                    if let _ = error["errors"] as? [String] {
                        HUD.flash(.error)
                        throw ErrorType.noPassword
                    }
                }
            
                if let _ = errors["username"] as? [String: Any] {
                    // Add for future case if back-end consider to replace this field as non-optional including cases for ErrorType
                }
        }
    }
    
}
