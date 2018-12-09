//
//  ProfileViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/1/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ProfileViewController: UIViewController {

    @IBOutlet weak var TxtFieldEmrgencyNum: UITextField!
    @IBOutlet weak var TxtFieldEmail: UITextField!
    @IBOutlet weak var ImgViewPP: UIImageView!
    @IBOutlet weak var TxtFieldUserName: UITextField!
    @IBOutlet weak var ImgViewCover: UIImageView!
    
    @IBOutlet weak var TxtFieldUserNum: UITextField!
    //let EditProfileVC = EditProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      makeRoundedImage(image: self.ImgViewPP)
      FetchProfileWithAlamofire()
        
    }
    
    
    
    func DawnloadImage(url : String) -> UIImage   {
        
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeRoundedImage(image : UIImageView) {
        
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.purple.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
    }
    
    
    func FetchProfileWithAlamofire()
    {
    
         let decoder = JSONDecoder()
         let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
         let CurrentUser = try? decoder.decode(UserModel.self, from: _CurrentUser!)
        // print ("\(CurrentUser)")
         let CurrentUserToken = CurrentUser?.token

         var  bearer = "Bearer "
         bearer += CurrentUserToken!
         
         let url = "https://safty.herokuapp.com/api/v1/profile"
         
         let header : [String: String] = [
         "Authorization" : bearer ,
         "Content-Type" : "application/json"
         ]
         
         Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (responseData) -> Void in
         if((responseData.result.value) != nil) {
            let swiftyJsonVar = JSON(responseData.result.value!)
                 let img = swiftyJsonVar["img"].stringValue
                 let cover = swiftyJsonVar["cover"].stringValue
                 let name = swiftyJsonVar["name"].stringValue
                 let email = swiftyJsonVar["email"].stringValue
                 let phone = swiftyJsonVar["phone"].stringValue
                 let emergencyNo = swiftyJsonVar["emergencyNo"].stringValue
            
            self.ImgViewPP.image = self.DawnloadImage(url: img)
           // self.ImgViewCover.image = self.DawnloadImage(url: cover)
            self.TxtFieldUserName.text = name
            self.TxtFieldEmail.text = email
            self.TxtFieldEmrgencyNum.text = emergencyNo
            self.TxtFieldUserNum.text = phone
             
            

            }
         }
    }//ENdFetchProfile
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GoEditProfile") {
            let vc = segue.destination as! EditProfileViewController
          //  vc.RecivedCover = self.ImgViewCover.image!
            vc.RecivedPP = self.ImgViewPP.image!
        }
    }

}///ClassENd

