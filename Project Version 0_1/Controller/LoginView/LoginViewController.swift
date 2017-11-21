//
//  LoginViewController.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 19.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var Login: UIButton!
    
    var emailFieldValidated : Bool = false
    var passwordFieldValidated : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        disableLoginButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonClick(_ sender: UIButton) {
                
        
        
    }
    

    /**
        email & password field must be check before login,
        if email or password is not validated login button must be disabled
        ..........
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
        
        let responsePasswordFieldValidation = Validation.shared.validate(values: (type: ValidationFields.passwordField, inputValue: password.text!))
        
        switch responsePasswordFieldValidation {
        case .success:
            print("password validation is ok")
            passwordFieldValidated = true
        default:
            print("password validation is failed")
            passwordFieldValidated = false
        }
        
        if emailFieldValidated && passwordFieldValidated {
            
            if (email.text?.isEmpty)! || (password.text?.isEmpty)! {
                
                Login.isEnabled = false
                
            } else {
                
                Login.isEnabled = true
                
            }
            
        }
        
    }
    
    /**
        disable login button
     */
    private func disableLoginButton() {
        
        Login.isEnabled = false
        
    }

}
