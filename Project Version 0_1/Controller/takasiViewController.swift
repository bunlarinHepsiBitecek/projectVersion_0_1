//
//  takasiViewController.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 19.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit

class takasiViewController: UIViewController {

    @IBOutlet var eeeee: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        animateBackgroundColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func animateBackgroundColor() {
        print("erkut")
        UIView.animate(withDuration: 15, delay: 0, options: [.autoreverse, .curveLinear, .repeat], animations: {
            
            print("lala")
            
            let x = -(self.eeeee.frame.width - self.view.frame.width)
            self.view.transform = CGAffineTransform(translationX: x, y: 0)
            
        })
        
    }

}
