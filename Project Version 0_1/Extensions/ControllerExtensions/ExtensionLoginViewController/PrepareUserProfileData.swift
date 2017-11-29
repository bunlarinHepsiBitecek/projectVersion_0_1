//
//  CreateUserProfileData.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 28.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController {
    
    func prepareUserLoginInfo(userObject : User) -> User {
        
        if let userID = userObject.userID as String? {
            
            userObject.appendAttributeToDictionary(inputKey: CONSTANT_STRING_USERID, inputValue: userID)
            
        }
        
        if let userName = userObject.username as String? {
            
            userObject.appendAttributeToDictionary(inputKey: CONSTANT_USERNAME, inputValue: userName)
            
        }
        
        if let nameSurname = userObject.userNameSurname as String? {
            
            userObject.appendAttributeToDictionary(inputKey: CONSTANT_NAME_SURNAME, inputValue: nameSurname)
        }
        
        if let email = userObject.email as String? {
            
            userObject.appendAttributeToDictionary(inputKey: CONSTANT_EMAIL, inputValue: email)
            
        }
        
        if let gender = userObject.gender as String? {
            
            userObject.appendAttributeToDictionary(inputKey: CONSTANT_GENDER, inputValue: gender)
            
        }
        
        if let birthday = userObject.birthday as String? {
            
            userObject.appendAttributeToDictionary(inputKey: CONSTANT_BIRTHDAY, inputValue: birthday)
            
        }
        
        return userObject
        
    }
    
}
