//
//  StartPageViewController.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 20.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class StartPageViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("ilk ekran")
        print("Entrance view starts")
        print("KeyChainData : \(KeychainWrapper.standard.string(forKey: USER_ID))")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
