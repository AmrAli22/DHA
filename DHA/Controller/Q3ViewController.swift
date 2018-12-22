//
//  Q3ViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/9/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class Q3ViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var TxtFieldResult: UITextView!
    var Q3Answer = ""
    var Q3AnswerType = ""

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var BtnLikLow1: UIButton!
    @IBOutlet weak var BtnLikMed2: UIButton!
    @IBOutlet weak var BtnLikHigh3: UIButton!
    
    
    @IBOutlet weak var BtnLow1: UIButton!
    @IBOutlet weak var BtnLow2: UIButton!
    @IBOutlet weak var BtnMed3: UIButton!
    
    @IBOutlet weak var BtnMedLow2: UIButton!
    @IBOutlet weak var BtnMed4: UIButton!
    @IBOutlet weak var BtnMedHigh6: UIButton!
    
    
    @IBOutlet weak var BtnMed5: UIButton!
    @IBOutlet weak var BtnHigh6: UIButton!
    @IBOutlet weak var BtnHigh9: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StateZero()

    }
    
    func StateZero(){
        
        BtnLikLow1.isEnabled = true
        BtnLikLow1.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        
        BtnLikMed2.isEnabled = true
        BtnLikMed2.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        
        BtnLikHigh3.isEnabled = true
        BtnLikHigh3.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        BtnLow1.isEnabled = false
        BtnLow1.backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1).withAlphaComponent(0.20)
        
        BtnLow2.isEnabled = false
        BtnLow2.backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1).withAlphaComponent(0.20)
        
        BtnMedLow2.isEnabled = false
        BtnMedLow2.backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1).withAlphaComponent(0.20)
        
        BtnMed3.isEnabled = false
        BtnMed3.backgroundColor = #colorLiteral(red: 0.9013670087, green: 0.8889318109, blue: 0.006358571351, alpha: 1).withAlphaComponent(0.20)
        
        BtnMed4.isEnabled = false
        BtnMed4.backgroundColor = #colorLiteral(red: 0.9013670087, green: 0.8889318109, blue: 0.006358571351, alpha: 1).withAlphaComponent(0.20)
        
        BtnMed5.isEnabled = false
        BtnMed5.backgroundColor = #colorLiteral(red: 0.9013670087, green: 0.8889318109, blue: 0.006358571351, alpha: 1).withAlphaComponent(0.20)
        
        BtnMedHigh6.isEnabled = false
        BtnMedHigh6.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1).withAlphaComponent(0.20)
        
        BtnHigh6.isEnabled = false
        BtnHigh6.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1).withAlphaComponent(0.20)
        
        BtnHigh9.isEnabled = false
        BtnHigh9.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1).withAlphaComponent(0.20)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnLikLow1Pres(_ sender: Any) {
        
        StateZero()
        
       // BtnLikMed2.isEnabled = false
        BtnLikMed2.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1).withAlphaComponent(0.20)
        
       // BtnLikHigh3.isEnabled = false
        BtnLikHigh3.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.20)
        
        BtnLow1.isEnabled = true
        BtnLow1.backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        
        BtnLow2.isEnabled = true
        BtnLow2.backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        
        BtnMed3.isEnabled = true
        BtnMed3.backgroundColor = #colorLiteral(red: 0.9013670087, green: 0.8889318109, blue: 0.006358571351, alpha: 1)
        
    }
    @IBAction func BtnLikMed2pres(_ sender: Any) {
        
        StateZero()
        
       // BtnLikLow1.isEnabled = false
        BtnLikLow1.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1).withAlphaComponent(0.20)
        
       // BtnLikHigh3.isEnabled = false
        BtnLikHigh3.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.20)
        
        BtnMedLow2.isEnabled = true
        BtnMedLow2.backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        
        BtnMed4.isEnabled = true
        BtnMed4.backgroundColor = #colorLiteral(red: 0.9013670087, green: 0.8889318109, blue: 0.006358571351, alpha: 1)
        
        BtnMedHigh6.isEnabled = true
        BtnMedHigh6.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        
    }
    @IBAction func BtnLikHigh3Pres(_ sender: Any) {
        
        StateZero()
        
       // BtnLikLow1.isEnabled = false
        BtnLikLow1.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1).withAlphaComponent(0.20)
        
       // BtnLikMed2.isEnabled = false
        BtnLikMed2.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1).withAlphaComponent(0.20)
        
        BtnMed5.isEnabled = true
        BtnMed5.backgroundColor = #colorLiteral(red: 0.9013670087, green: 0.8889318109, blue: 0.006358571351, alpha: 1)
        
        BtnHigh6.isEnabled = true
        BtnHigh6.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        
        BtnHigh9.isEnabled = true
        BtnHigh9.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        
    }
    
    
    @IBAction func BtnLow1press(_ sender: Any) {
        appDelegate.Q3_Answer = "low"
        appDelegate.valueOfQ3 = "1"
        self.TxtFieldResult.text = "1 * 1 = 1 ( Low )"
        
    }
    @IBAction func BtnLow2Press(_ sender: Any) {
        appDelegate.Q3_Answer = "2"
        appDelegate.valueOfQ3 = "low"
          self.TxtFieldResult.text = "1 * 2 = 2 ( Low )"
    }
    @IBAction func BtnMed3Press(_ sender: Any) {
       appDelegate.Q3_Answer = "3"
        appDelegate.valueOfQ3 = "Meduim"
          self.TxtFieldResult.text = "1 * 3 = 3 ( Meduim )"
    }
    
   
    @IBAction func BtnMedLow2Press(_ sender: Any) {
       appDelegate.Q3_Answer = "2"
       appDelegate.valueOfQ3 = "low"
          self.TxtFieldResult.text = "2 * 1 = 2 ( Meduim )"
    }
    @IBAction func BtnMedMed4Press(_ sender: Any) {
       appDelegate.Q3_Answer = "4"
        appDelegate.valueOfQ3 = "Meduim"
          self.TxtFieldResult.text = "2 * 2 = 4 ( meduim )"
    }
    @IBAction func BtnMedHigh6Press(_ sender: Any) {
        appDelegate.Q3_Answer = "6"
        appDelegate.valueOfQ3 = "High"
          self.TxtFieldResult.text = "2 * 3 = 6 ( High )"
    }
    
    
    @IBAction func BtnMed5Press(_ sender: Any) {
        appDelegate.Q3_Answer = "3"
        appDelegate.valueOfQ3 = "Meduim"
          self.TxtFieldResult.text = "3 * 2 = 1 ( Meduim )"
    }
    @IBAction func BtnHigh6Press(_ sender: Any) {
        appDelegate.Q3_Answer = "6"
        appDelegate.valueOfQ3 = "High"
          self.TxtFieldResult.text = "3 * 2 = 6 ( High )"
    }
    @IBAction func BtnHigh9Press(_ sender: Any) {
        appDelegate.Q3_Answer = "9"
       appDelegate.valueOfQ3 = "High"
          self.TxtFieldResult.text = "3 * 3 = 9 ( High )"
    }
}
