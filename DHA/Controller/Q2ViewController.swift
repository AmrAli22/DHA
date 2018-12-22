//
//  Q2ViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/9/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class Q2ViewController: UIViewController , UITextFieldDelegate  {

    
    
    @IBOutlet weak var TxtFieldOtherTypes: UITextField!
    @IBOutlet weak var BtnCheckOther: CheckBox!
    @IBOutlet weak var BtnCheckProbertyDamage: CheckBox!
    @IBOutlet weak var BtnCheckFacility: CheckBox!
    @IBOutlet weak var BtnCheckPeople: CheckBox!
    @IBOutlet weak var BtnCheckEquipment: CheckBox!
    @IBOutlet weak var BtnCheckEnviroment: CheckBox!
    
    var Q2Answers = [String]()
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TxtFieldOtherTypes.isHidden = true
        
        // Do any additional setup after loading the view.
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnOtherPressed(_ sender: Any) {
        if BtnCheckOther.isChecked == false {
             TxtFieldOtherTypes.isHidden = false
        }else{
            TxtFieldOtherTypes.isHidden = true
        }
    }
    @IBAction func BtnNextPressed(_ sender: Any) {
        
        appDelegate.Q2_Answer.removeAll()
        
        if BtnCheckOther.isChecked {
            if TxtFieldOtherTypes.text == "" {
            }else{
                self.Q2Answers.append("\(TxtFieldOtherTypes.text!)")
            }
        }
        if BtnCheckProbertyDamage.isChecked {
            self.Q2Answers.append("Proberty Damage")
        }
        if BtnCheckFacility.isChecked {
            self.Q2Answers.append("Facility")
        }
        if BtnCheckPeople.isChecked {
            self.Q2Answers.append("People")
        }
        if BtnCheckEquipment.isChecked {
            self.Q2Answers.append("Equipment")
        }
        if BtnCheckEnviroment.isChecked {
            self.Q2Answers.append("Enviroment")
        }
        
        appDelegate.Q2_Answer = self.Q2Answers
        print(self.Q2Answers)
        
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
