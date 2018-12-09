//
//  SplashViewController.swift
//  DHA
//
//  Created by AmrAli on 11/19/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var UIViewAlphaRed: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)

        self.UIViewAlphaRed.backgroundColor = #colorLiteral(red: 0.8787010908, green: 0.3304585814, blue: 0.3257992268, alpha: 1).withAlphaComponent(0.4)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            // your code here
           self.performSegue(withIdentifier: "SplashEnd", sender: self)
        }
        
        // Do any additional setup after loading the view.
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
