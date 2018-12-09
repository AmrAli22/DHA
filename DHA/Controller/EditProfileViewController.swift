//
//  EditProfileViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/2/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditProfileViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var ImgViewCover: UIImageView!
    
    @IBOutlet weak var BtnEditCover: UIButton!
    @IBOutlet weak var ViewEditCover: UIView!
    
    @IBOutlet weak var ImgViewPP: UIImageView!
    @IBOutlet weak var ViewEditPP: UIView!
    @IBOutlet weak var BtnEditPP: UIButton!
    
    @IBOutlet weak var TxtFieldFullName: UITextField!
    @IBOutlet weak var TxtFieldEmail: UITextField!
    @IBOutlet weak var Txtfieldphone: UITextField!
    @IBOutlet weak var TxtFieldEmrgNum: UITextField!
    
    //  let ProfilVC = ProfileViewController()
    var RecivedPP = UIImage()
    var RecivedCover = UIImage()
    
    
    //EndOutlets
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makeRoundedview(Roundedview: ViewEditPP)
        
        self.BtnEditCover.layer.cornerRadius = 0.5 * BtnEditCover.bounds.size.width
        self.BtnEditCover.clipsToBounds = true
        
        self.BtnEditPP.layer.cornerRadius = 0.5 * BtnEditCover.bounds.size.width
        self.BtnEditPP.clipsToBounds = true
        
        makeRoundedImage(image: self.ImgViewPP) 
        
        self.ImgViewPP.image = RecivedPP
        self.ImgViewCover.image = RecivedCover
        
        // self.MakeRoundedButtons(Button: self.BtnEditPP)
        // self.MakeRoundedButtons(Button: self.BtnEditCover)
        
        self.ViewEditPP.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        
        self.ViewEditCover.backgroundColor = UIColor.black.withAlphaComponent(0.30)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ActBtnEditCover(_ sender: Any) {
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.ImgViewCover.image = image
            
            
        }
        
    }
    @IBAction func BtnActSave(_ sender: Any) {
        
        UpdateProfileWithAlamoFire(name: TxtFieldFullName.text! , phone: Txtfieldphone.text!, email: TxtFieldEmail.text!, emergencyNum: TxtFieldEmrgNum.text!, img: ImgViewPP.image!, cover: ImgViewCover.image!)
        
        
    }
    @IBAction func ActBtnEditpp(_ sender: Any) {
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.ImgViewPP.image = image
            
        }
    }
    
    /*  func MakeRoundedButtons(Button : UIButton)
     {
     
     Button.layer.cornerRadius = 5
     Button.layer.borderWidth = 1
     Button.layer.borderColor = UIColor.white.cgColor
     
     }*/
    
    func makeRoundedview(Roundedview : UIView){
        Roundedview.layer.borderWidth = 1
        Roundedview.layer.masksToBounds = false
        Roundedview.layer.borderColor = UIColor.purple.cgColor
        Roundedview.layer.cornerRadius = Roundedview.frame.height/2
        Roundedview.clipsToBounds = true
    }
    
    func makeRoundedImage(image : UIImageView) {
        
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.purple.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
    }
    
    func UpdateProfileWithAlamoFire(name :String , phone :String , email :String ,emergencyNum :String , img :UIImage , cover : UIImage  )
    {
        
        let decoder = JSONDecoder()
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(UserModel.self, from: _CurrentUser!)
        let CurrentUserToken = CurrentUser?.token
        
        
        
        var  bearer = "Bearer "
        bearer += CurrentUserToken!
        
        let header : [String: String] = [
            "Authorization" : bearer ,
            "Content-Type" : "application/json"
        ]
        
        let parameters : [String : String?] = [
            "name" :  name  ,
            "phone" :   phone ,
            "email" :   email  ,
            "emergencyNo" : emergencyNum ,
            ]
        
        let URL =  "https://safty.herokuapp.com/api/v1/profile"
        
        let imageData : Data = UIImagePNGRepresentation(img)!
        let CoverData : Data = UIImagePNGRepresentation(cover)!
        
        
        ////////////
        print("start")
        Alamofire.upload(multipartFormData:{ multipartFormData in
        
            for (key, value) in parameters {
                
                if let string = value, !string.isEmpty {
                    multipartFormData.append("\(string)".data(using: String.Encoding.utf8)!, withName: key as String)
                     print("\(key)\(value)")
                }
            }
            
            multipartFormData.append(imageData, withName: "image")
            multipartFormData.append(CoverData, withName: "cover")
            print(imageData)
        },
                        
                         usingThreshold:UInt64.init(),
                         to:URL,
                         method:.put,
                         headers : header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    debugPrint(response)
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        })
        
        ///////////
    
    }//ENDOFFUNCUPLOAD
}//ENDOFCLASS

