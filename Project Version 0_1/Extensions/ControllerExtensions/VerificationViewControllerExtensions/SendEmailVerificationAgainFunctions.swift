//
//  SendEmailVerificationAgainFunctions.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 28.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

extension VerificationViewController {
    
    func sendVerificationMail() {
        
        let currentUser = Auth.auth().currentUser
        
        let actionCodeSettingsObject = ActionCodeSettings.init()
        
        actionCodeSettingsObject.url = URL(string: String(format: EMAIL_VERIFICATON_URL, emailStringValue))
        
        actionCodeSettingsObject.setIOSBundleID(BUNDLE_IDENTIFIER)
        
        currentUser?.sendEmailVerification(with: actionCodeSettingsObject, completion: { (error) in
            
            print("email verification basliyorrrrrrrrrrrrrrr")
            
            if error != nil {
                
                print("hata geldi")
                
                if let errorMessage = error as NSError? {
                    
                    print("errorMessage : \(errorMessage)")
                    print("errorMessage : \(errorMessage.userInfo)")
                    print("errorMessage : \(errorMessage.localizedDescription)")
                    
                }
                
                
            } else {
                
                print("email verification sent")
                
            }
        })
        
    }
    
}
