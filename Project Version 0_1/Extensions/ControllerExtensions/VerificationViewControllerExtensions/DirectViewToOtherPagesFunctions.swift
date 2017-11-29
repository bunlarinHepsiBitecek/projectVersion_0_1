//
//  DirectViewToOtherPagesFunctions.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 28.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

extension VerificationViewController {
    
    func manageForegroundActions() {
        
        let action = #selector(checkUserEmailIsVerifiedAndDirectToMainPage)
        
        NotificationCenter.default.addObserver(self, selector: action, name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
    }
    
    @objc func checkUserEmailIsVerifiedAndDirectToMainPage() {
        
        Auth.auth().currentUser?.reload(completion: { (error) in
            
            if error != nil {
                
                if let errorMessage = error as NSError? {
                    
                    print("errorMessage : \(errorMessage)")
                    print("errorMessage : \(errorMessage.userInfo)")
                    print("errorMessage : \(errorMessage.localizedDescription)")
                    
                }
                
            } else {
                
                if let userObject = Auth.auth().currentUser {
                    
                    if userObject.isEmailVerified {
                        
                        self.directCurrentPageToMainPage()
                        
                    }
                    
                }
                
            }
            
        })
        
    }
    
    func directCurrentPageToMainPage() {
        
        let mainPageViewControllerObject = storyboard?.instantiateViewController(withIdentifier: "mainPageVC_storyBoardID") as! MainPageViewController
        
        navigationController?.pushViewController(mainPageViewControllerObject, animated: true)
        
    }
}
