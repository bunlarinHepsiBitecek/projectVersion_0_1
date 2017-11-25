//
//  NavigationBarController.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 24.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func  disableNavigationBar() {
        
        self.isNavigationBarHidden = true
        
    }
    
    func  enableNavigationBar() {
        
        self.isNavigationBarHidden = false
        
    }
    
}
