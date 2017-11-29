//
//  UITextFieldExtensions.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 24.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit

extension UITextField {
    
    // check if a text field is empty or not
    func checkTextFieldHasStringValue() -> Bool {
        
        if let stringValue = self.text as String? {
            
            if stringValue.isEmpty {
                
                return false
                
            } else {
                
                return true
                
            }
            
        } else {
            
            return false
            
        }
    }
        
}
