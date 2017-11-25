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
import SwiftKeychainWrapper
import TextFieldEffects

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var Login: UIButton!
    @IBOutlet var forgotPasswordButton: UIButton!
    
    var emailFieldValidated : Bool = false
    var passwordFieldValidated : Bool = false
    var emailStringValue : String = SPACE_CHARACTER
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.enableNavigationBar()
        
        email.text = "erkutbas007@gmail.com"
        password.text = "123456"
        
        disableLoginButton()
        
        //testTogoVerificationPanel()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("TouchesBegan is activated")
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn is activated")
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    /*
        test functions
     */
    func testTogoVerificationPanel() {
        
        let verificationViewControllerObject = storyboard?.instantiateViewController(withIdentifier: "VerificationViewControllerID") as! VerificationViewController
     
        verificationViewControllerObject.emailStringValue = "taksi@hotmail.com"
        
        navigationController?.pushViewController(verificationViewControllerObject, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     disable login button
     */
    func disableLoginButton() {
        
        Login.isEnabled = false
        
    }
    
    @IBAction func loginButtonClick(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            
            /*
                error handling onto firebase ???
             */
            if error != nil {
                
                if let errorMessage = error as NSError? {
                    
                    print("LoginButtonClick : \(errorMessage)")
                    print("LoginButtonClick : \(errorMessage.userInfo)")
                    print("LoginButtonClick : \(errorMessage.localizedDescription)")
                    
                }
                
                Firebase.AuthErrorCode(rawValue: (error?._code)!)
                
                if let errorCode = Firebase.AuthErrorCode(rawValue: (error?._code)!) {
                    
                    switch errorCode {
                        
                    case .userNotFound:
                        print("user is not found, let's create one")
                        self.createUserWithCredentials()
                        
                    default:
                        print("nothing to do at this point")
                    }
                }
            
                /*
                    user is already created and logged in process is successfull
                 */
            } else {
                
                print("loginButtonClick : user is logged in successfully")
                print("loginButtonClick : user.isEmailVerified : \(user?.isEmailVerified)")
                // let's check user object is not null
                if let user = user {
                    
                    if user.isEmailVerified == false {
                        
                        self.gotoVerificationPanel()
                        
                    } else {
                        
                        self.directCurrentPageToMainPage()
                        
                    }
                }
            }
        }
    }
    
    /*
        direct to main page
     */
    private func directCurrentPageToMainPage() {
        
        let mainPageViewControllerObject = storyboard?.instantiateViewController(withIdentifier: "mainPageVC_storyBoardID") as! MainPageViewController
        
        navigationController?.pushViewController(mainPageViewControllerObject, animated: true)
        
    }
    
    /*
        if user mail address is not verified, force the account to get verified.....
     */
    func gotoVerificationPanel() {
        
        //performSegue(withIdentifier: "gotoVerificationPanel", sender: self)
        
        let verificationViewControllerObject = storyboard?.instantiateViewController(withIdentifier: "VerificationViewControllerID") as! VerificationViewController
        
        verificationViewControllerObject.emailStringValue = email.text!
        //verificationViewControllerObject.callerViewControllerID = self.restorationIdentifier!
        
        navigationController?.pushViewController(verificationViewControllerObject, animated: true)
        
    }
    
    func createUserWithCredentials() {
        
        let userDatabaseObject = User()
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if error != nil {
                print("createUserWithCredentials : Unable to authenticate with Firebase using email")
                
                if let errorMessage = error as NSError? {
                    
                    print("createUserWithCredentials : errorMessage : \(errorMessage.userInfo)")
                    print("createUserWithCredentials : errorMessage : \(errorMessage)")
                    
                }
                
                if let errorCode = Firebase.AuthErrorCode(rawValue: (error?._code)!) {
                    
                    print("createUserWithCredentials : ErrorCode : \(errorCode.rawValue)")
                    
                }
                
                
            } else {
                
                print("createUserWithCredentials : User successfully created in firebase")
                // ... save userID to keyChainWrapper
                
                if let userObject = user {
                    
                    if let userID = userObject.uid as String? {
                        print("createUserWithCredentials : userID : \(userID)")
                        self.registerCurrentUserToKeyChain(inputUserID: userID, inputUserIDKey: USER_ID)
                        
                        userDatabaseObject.setUserID(inputUserID: userID)
                        userDatabaseObject.setUserName(inputName: "baserkut")
                        userDatabaseObject.setUserNameSurname(inputNameSurname: "Erkut Bas")
                        userDatabaseObject.setUserEmail(inputEmail: self.email.text!)
                        userDatabaseObject.setUserGender(inputUserGender: "erkek")
                        userDatabaseObject.setUserBirthday(inputUserBirthday: "18.3.1988")
                        
                        userDatabaseObject.appendAttributeToDictionary(inputKey: CONSTANT_USERNAME, inputValue: userDatabaseObject.username)
                    
                        userDatabaseObject.appendAttributeToDictionary(inputKey: CONSTANT_NAME_SURNAME, inputValue: userDatabaseObject.userNameSurname)
                        
                        userDatabaseObject.appendAttributeToDictionary(inputKey: CONSTANT_EMAIL, inputValue: userDatabaseObject.email)
                        
                        userDatabaseObject.appendAttributeToDictionary(inputKey: CONSTANT_GENDER, inputValue: userDatabaseObject.gender)
                        
                        DatabaseUser.ds.createFirbaseDatabaseUser(userID: userID, userData: userDatabaseObject.userDictionary)
                        
                    }
                    
                }
                
                print("createUserWithCredentials : keyChainData : \(KeychainWrapper.standard.data(forKey: USER_ID))")
                print("createUserWithCredentials : keyChainData : \(KeychainWrapper.standard.string(forKey: USER_ID))")
                
            }
        }
    }
    
    /**
        if the user forgets his/her password, we make him/her a chance to reset it
     */
    @IBAction func forgotPasswordButtonClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "gotoForgotPasswordView", sender: self)
        
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
    
    
    /*
        SwiftKeyChainWrapper functions
     */
    
    private func registerCurrentUserToKeyChain(inputUserID : String, inputUserIDKey : String) {
        
        let _ : Bool = KeychainWrapper.standard.set(inputUserID, forKey: inputUserIDKey)
        
    }
        
}
























