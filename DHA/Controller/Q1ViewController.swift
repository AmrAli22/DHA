//
//  Q1ViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/7/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class Q1ViewController: UIViewController {
    
    
    @IBOutlet weak var TxtFieldAnswer: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
      let ReportQ1Answer = self.TxtFieldAnswer.text
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       
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
