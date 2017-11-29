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
    var userObjectInVerificationView = User()
    @IBOutlet var verificationInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.enableNavigationBar()
        self.manageForegroundActions()
        
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
        
        sendVerificationMail()
        
    }
    
}
