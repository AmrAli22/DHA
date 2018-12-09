//
//  LoginViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 11/19/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var TxtfieldEmail: UITextField!
    @IBOutlet weak var TxtFieldPassword: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnActLogin(_ sender: Any) {
        
        loginWithAlamofire(email: TxtfieldEmail.text!, pass: TxtFieldPassword.text!)
        
    }
    
    
    func DawnloadImage(url : String) -> UIImage   {
        
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)!
    }
    
    func loginWithAlamofire(email : String , pass : String)
    {
        
        let parameters: [String: String] = [
            "email" : email,
            "password" : pass
        ]
        
        let header : [String: String] = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("https://safty.herokuapp.com/api/v1/signin", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                //    print(response.result.value)
                   
                    let json = JSON(data)
                    let name = json["user"]["name"]
                    let email = json["user"]["email"]
                    let emergencyNo = json["user"]["emergencyNo"]
                    let id = json["user"]["id"]
                    let img = json["user"]["img"]
                    let phone = json["user"]["phone"]
                  
                    let Token = json["token"]
                    
                   let imageAsimage =  self.DawnloadImage(url: img.stringValue)
                    let imageAsData : Data = UIImagePNGRepresentation(imageAsimage)!
                    
                    let NewUser = UserModel(name: name.stringValue, password: "", phone: phone.stringValue, email: email.stringValue.description , img: imageAsData , emergencyNo: emergencyNo.stringValue , id: "\(id)" ,token: Token.stringValue)
                    
                    print("THESIGNINUSER = \(NewUser)")
                    
                    
                    if let encoded = try? JSONEncoder().encode(NewUser) {
                    UserDefaults.standard.set(encoded, forKey: "kUser")

                    }

                }
                break
                
            case .failure(_):
                print(response.result.error!)
                break
                
            }
        }
    }
}


