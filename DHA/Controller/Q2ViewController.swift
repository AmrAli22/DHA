//
//  Q2ViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/9/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class Q2ViewController: UIViewController {

    @IBOutlet weak var BtnCheckOther: CheckBox!
    @IBOutlet weak var BtnCheckProbertyDamage: CheckBox!
    @IBOutlet weak var BtnCheckFacility: CheckBox!
    @IBOutlet weak var BtnCheckPeople: CheckBox!
    @IBOutlet weak var BtnCheckEquipment: CheckBox!
    @IBOutlet weak var BtnCheckEnviroment: CheckBox!
    
    var Q2Answers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnNextPressed(_ sender: Any) {
        
        if BtnCheckOther.isChecked {
            self.Q2Answers.append("Other")
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
