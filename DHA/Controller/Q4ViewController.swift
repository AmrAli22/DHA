//
//  Q4ViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/9/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class Q4ViewController: UIViewController , UITextFieldDelegate  {

    
    @IBOutlet weak var BtnEngineering: CheckBox!
    @IBOutlet weak var BtnAdministrative: CheckBox!
    @IBOutlet weak var BtnPPE: CheckBox!
    @IBOutlet weak var BtnOther: CheckBox!
    
    var Q4Answer = [String]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnActNext(_ sender: Any) {
        if BtnEngineering.isChecked {
            self.Q4Answer.append("Engineering")
            
        }
        
        if BtnAdministrative.isChecked {
            self.Q4Answer.append("Administrative")
        }
        
        if BtnPPE.isChecked {
            self.Q4Answer.append("PPE")
        }
        if BtnOther.isChecked {
            self.Q4Answer.append("Other")
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func BtnActNexWasPressed(_ sender: Any) {
        appDelegate.Q4_Answer = self.Q4Answer
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
