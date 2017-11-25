//
//  EntranceViewController.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 19.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit

class EntranceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.disableNavigationBar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        self.navigationController?.disableNavigationBar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "gotoLoginPage", sender: self)
        
    }
    @IBAction func registerButton(_ sender: UIButton) {
        
         performSegue(withIdentifier: "gotoRegisterPage", sender: self)
        
    }
    
}
