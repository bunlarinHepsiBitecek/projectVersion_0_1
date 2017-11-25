//
//  VerificationViewController.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 21.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class VerificationViewController: UIViewController {

    @IBOutlet var emailVerificationTextField: UITextField!
    
    var emailStringValue : String = SPACE_CHARACTER
    var callerViewControllerID : String = SPACE_CHARACTER
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("VerificationViewController starts")
        print("viewDidLoad : callerViewControllerID : \(callerViewControllerID)")
        
        emailVerificationTextField.text = emailStringValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSendVerificationEmailAgain(_ sender:
        UIButton) {
        
        let currentUser = Auth.auth().currentUser
        
        var actionCodeSettingsObject = ActionCodeSettings.init()
        actionCodeSettingsObject.url = URL(string: String(format: "gotoVerify://social-media-infinity.firebaseapp.com?email=%@", emailStringValue))
        
        actionCodeSettingsObject.setIOSBundleID("com.erkutbas.Project-Version-0-1")
        
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
