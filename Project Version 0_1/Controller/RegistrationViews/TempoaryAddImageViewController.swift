
//
//  TempoaryAddImageViewController.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 24.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit

class TempoaryAddImageViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var continueVerificationPageButton: UIButton!
    
    var userObject = User.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getProfilePhoto)))
        imageView.isUserInteractionEnabled = true
        
        imageView.setRoundedDesignToProfilePictureImageViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("ttttt")
        
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.layer.masksToBounds = false
        self.imageView.clipsToBounds = true
        //self.imageView.layer.borderWidth = 1
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deneme(_ sender: UIButton) {
    
        print("deneme takasi")
        print(userObject.email)
        print(userObject.userID)
        self.decideHowProfilePictureLoads()
        
    }
    
    @IBAction func gotoVerificationPage(_ sender: UIButton) {
        
        let verificationViewControllerObject = storyboard?.instantiateViewController(withIdentifier: "VerificationViewControllerID") as! VerificationViewController
        
        createUserAndLoadDataToStorage()
        
        if sendVerificationMail() {
            
            verificationViewControllerObject.verificationInfoLabel.text = USER_EMAIL_VERIFICATION_NOTIF_SUCCESS
            
        } else {
            
            verificationViewControllerObject.verificationInfoLabel.text = USER_EMAIL_VERIFICATION_NOTIF_FAILED
            
        }
        
        verificationViewControllerObject.userObjectInVerificationView = userObject
        
        navigationController?.pushViewController(verificationViewControllerObject, animated: true)
        
        
    }
}
