//
//  ViewController.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 18.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper

class ViewController: UIViewController {

    var second_three : Int = 2
    var timer = Timer()
    var isTimerRunning : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.disableNavigationBar()
        
        runTimer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func runTimer() {
        
        let action = #selector(countDown)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: action, userInfo: nil, repeats: true)
        
    }
    
    @objc private func countDown() {
        
        second_three -= 1
        
        if second_three == 0 {
            
            //performSegue(withIdentifier: "gotoEntrancePage", sender: self)
            decideWhichPageWouldLoad()
            
        }
    }
    
    private func decideWhichPageWouldLoad() {
        
        print("decideWhichPageWouldLoad starts")
        
        if let loggedInUser = Auth.auth().currentUser {
            
            print("isEmailVerified : \(loggedInUser.isEmailVerified)")
            
            if let resultKeyChainWrapper = KeychainWrapper.standard.string(forKey: USER_ID) {
                
                if loggedInUser.uid == resultKeyChainWrapper {
                    
                    if loggedInUser.isEmailVerified {
                        
                        print("currentUser is active")
                        
                        directCurrentPageToMainPage()
                        
                    } else {
                        
                        print("current user's email is not verified")
                        performSegue(withIdentifier: "gotoEntrancePage", sender: self)
                        
                    }
                    
                } else {
                    
                    print("current user's keychain is not registerd")
                    performSegue(withIdentifier: "gotoEntrancePage", sender: self)
                    
                }
            }
            
        } else {
            
            print("user is signed out")
            performSegue(withIdentifier: "gotoEntrancePage", sender: self)
            
        }
    }
    
    private func directCurrentPageToMainPage() {
        
        let mainPageViewControllerObject = storyboard?.instantiateViewController(withIdentifier: "mainPageVC_storyBoardID") as! MainPageViewController
        
        navigationController?.pushViewController(mainPageViewControllerObject, animated: true)
        
    }

}

