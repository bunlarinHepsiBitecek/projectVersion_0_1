//
//  Validations.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 20.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import Foundation

enum Alert {
    case success
    case failure
    case error
}

enum ValidationResults {
    case success
    case failure(Alert, AlertMessages)
}

enum ValidationFields {
    case emailField
    case passwordField
}

enum RegEx: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" // Email
    case password = "^.{6,15}$" // Password length 6-15
}

enum AlertMessages: String {
    case invalidEmail = "Invalid Email"
    case invalidPassword = "Invalid Password"
    
    case emptyEmail = "Empty Email"
    case emptyPassword = "Empty Password"
    
    func localized() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

class Validation: NSObject {
    
    public static let shared = Validation()
    
    func validate(values: (type: ValidationFields, inputValue: String)...) -> ValidationResults {
        
        for valueToBeChecked in values {
            
            switch valueToBeChecked.type {
                
            case .emailField:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .email, .emptyEmail, .invalidEmail)) {
                    return tempValue
                }
                
            case .passwordField:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .password, .emptyPassword, .invalidPassword)) {
                    return tempValue
                }
            }
        }
        
        return .success
    }
    
    
    func isValidString(_ input: (text: String, regex: RegEx, emptyAlert: AlertMessages, invalidAlert: AlertMessages)) -> ValidationResults? {
        
        if input.text.isEmpty {
            return .failure(.error, input.emptyAlert)
            
        } else if isValidRegEx(input.text, input.regex) != true {
            
            return .failure(.error, input.invalidAlert)
        }
        return nil
    }
    
    func isValidRegEx(_ testStr: String, _ regex: RegEx) -> Bool {
        
        let stringTest = NSPredicate(format:"SELF MATCHES %@", regex.rawValue)
        let result = stringTest.evaluate(with: testStr)
        return result
        
    }
}
