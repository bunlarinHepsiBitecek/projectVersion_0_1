//
//  ViewController.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 18.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var second_three : Int = 3
    var timer = Timer()
    var isTimerRunning : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
            
            performSegue(withIdentifier: "gotoEntrancePage", sender: self)
            
        }
    }

}

