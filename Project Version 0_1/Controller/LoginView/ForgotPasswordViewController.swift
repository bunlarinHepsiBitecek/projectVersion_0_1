//
//  ForgotPasswordViewController.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 24.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var email: UITextField!
    @IBOutlet var continueButton: UIButton!
    
    var emailFieldValidated : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.enableNavigationBar()
        
        email.text = "erkutbas007@gmail.com"
        
        continueButton.disableButton()
        manageForegroundActions()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func manageForegroundActions() {
        
        let action = #selector(checkUserPasswordResetAndPerformLoginPage)
        
        NotificationCenter.default.addObserver(self, selector: action, name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
    }
    
    @objc private func checkUserPasswordResetAndPerformLoginPage() {
        
        let loginViewControllerObject = storyboard?.instantiateViewController(withIdentifier: "LoginViewController_storyBoardID") as! LoginViewController
        
        loginViewControllerObject.emailStringValue = email.text!
        
        navigationController?.pushViewController(loginViewControllerObject, animated: true)
        
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        
        var actionCodeSettingsObject = ActionCodeSettings.init()
        actionCodeSettingsObject.url = URL(string: String(format: "gotoVerify://social-media-infinity.firebaseapp.com?email=%@", email.text!))
        
        actionCodeSettingsObject.setIOSBundleID("com.erkutbas.Project-Version-0-1")
        
        Auth.auth().sendPasswordReset(withEmail: email.text!, actionCodeSettings: actionCodeSettingsObject) { (error) in
        
            if error != nil {
                
                if let errorMessage = error as NSError? {
                    
                    print("errorMessage : \(errorMessage.localizedDescription)")
                    print("errorMessage : \(errorMessage.userInfo)")
                    
                }
                
            } else {
                
                print("password reset email sent")
            }
            
        }
        
    }
    
    /*
        validation functions
     */
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print("textFieldDidEndEditing")
        
        let responseEmailFieldValidation = Validation.shared.validate(values: (type: ValidationFields.emailField, inputValue: email.text!))
        
        switch responseEmailFieldValidation {
        case .success:
            print("email validation is ok")
            emailFieldValidated = true
        default:
            print("email validation is failed")
            emailFieldValidated = false
        }
        
        if email.checkTextFieldHasStringValue() && emailFieldValidated {
            
            continueButton.enableButton()
            
        } else {
            
            continueButton.disableButton()
        }
        
    }
    
    
}
