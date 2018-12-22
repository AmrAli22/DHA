//
//  Q4ViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/9/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class Q4ViewController: UIViewController , UITextFieldDelegate  {

    @IBOutlet weak var TxtFeildOthers: UITextField!
    
    @IBOutlet weak var BtnEngineering: CheckBox!
    @IBOutlet weak var BtnAdministrative: CheckBox!
    @IBOutlet weak var BtnPPE: CheckBox!
    @IBOutlet weak var BtnOther: CheckBox!
    
    var Q4Answer = [String]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

       TxtFeildOthers.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnOtherWasPressed(_ sender: Any) {
        
        if BtnOther.isChecked {
            if TxtFeildOthers.text == "" {
            }else{
                self.Q4Answer.append("\(TxtFeildOthers.text!)")
            }
        }
    }
    
    
    @IBAction func BtnActNext(_ sender: Any) {
        
        appDelegate.Q4_Answer.removeAll()
        
        if BtnEngineering.isChecked {
           self.appDelegate.Q4_Answer.append("Engineering")
            
        }
        
        if BtnAdministrative.isChecked {
            self.appDelegate.Q4_Answer.append("Administrative")
        }
        
        if BtnPPE.isChecked {
            self.appDelegate.Q4_Answer.append("PPE")
        }
        if BtnOther.isChecked {
            if TxtFeildOthers.text! == "" {
                
            }else{
               self.appDelegate.Q4_Answer.append(TxtFeildOthers.text!)
            }
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func BtnActNexWasPressed(_ sender: Any) {
        appDelegate.Q4_Answer = self.Q4Answer
    }
}

