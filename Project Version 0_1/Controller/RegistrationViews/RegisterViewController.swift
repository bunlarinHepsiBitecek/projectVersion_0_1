//
//  RegisterViewController.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 19.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var birthdateField: UITextField!
    
    @IBOutlet var sexManButton: UIButton!
    @IBOutlet var sexWomenButton: UIButton!
    
    @IBAction func sexButtonTapped(_ sender: UIButton) {
        sexSwitchControl(sender: sender)
    }
    
    
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the maksimum height of device size
        // iPhone 5s => 568
        // iPhone 6s => 667
        scrollView.contentSize.height = self.view.frame.height
        
        createDatePicker()
        setSexButtonTag()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSexButtonTag() {
        sexManButton.tag = 1
        sexWomenButton.tag = 2
    }
    
    func sexSwitchControl(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.tag {
        case 1:
            if(sexManButton.isSelected) {
                sexWomenButton.isEnabled = false
            }  else {
                sexWomenButton.isEnabled = true
            }
            break;
        case 2:
            if(sexWomenButton.isSelected) {
                sexManButton.isEnabled = false
            } else {
                sexManButton.isEnabled = true
            }
            break;
        default: ()
        break;
        }
    }
    
    func createDatePicker() {
        //
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        birthdateField.inputAccessoryView = toolbar
        birthdateField.inputView = picker
        
        picker.datePickerMode = UIDatePickerMode.date
        1    }
    
    @objc func donePressed() {
        birthdateField.text = dateFormatText(datePicker: picker)
        self.view.endEditing(true)
    }
    
    func dateFormatText(datePicker: UIDatePicker) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        return formatter.string(from: datePicker.date)
    }
    
    @IBAction func gotoAddImage(_ sender: Any) {
        
        performSegue(withIdentifier: "gotoAddImageAndVerificationSend", sender: self)
        
    }
    
    
    
}

