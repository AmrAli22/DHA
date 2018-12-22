//
//  Q1ViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/7/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class Q1ViewController: UIViewController , UITextFieldDelegate  {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var TxtFieldAnswer: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func FinishTyping(_ sender: Any) {
    
        appDelegate.Q1_Answer = self.TxtFieldAnswer.text
        print("Q1 = \(self.TxtFieldAnswer.text!)" )
        
    }
    
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
