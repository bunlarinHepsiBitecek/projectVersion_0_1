//
//  PageItemController.swift
//  Page View Project
//
//  Created by Remzi on 23/11/2017.
//  Copyright © 2017 Remzi. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
    
    // MARK: - Variables
    // ***
    var itemIndex: Int = 0
    
    // ***
    var imageName: String = "" {
        
        didSet {
            
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }


    @IBOutlet var contentImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        contentImageView!.image = UIImage(named: imageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
