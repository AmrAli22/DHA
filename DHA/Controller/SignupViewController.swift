//
//  SignupViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 11/25/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import BSImagePicker
import Photos
import SwiftyJSON

class SignupViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var BtnUploadPP: UIButton!
    
    var SelectedAssets = [PHAsset]()
    var PhotoArray = [UIImage]()
    
    var PPImage = UIImage()
    
    @IBOutlet weak var TxtFieldUserName: UITextField!
    @IBOutlet weak var TxtFieldEmail: UITextField!
    @IBOutlet weak var TxtFieldPassword: UITextField!
    @IBOutlet weak var TxtFieldPhone: UITextField!
    @IBOutlet weak var TxtFieldEmrgNum: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        TxtFieldEmrgNum.attributedPlaceholder = NSAttributedString(string: "Emergency Number",
        attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        BtnUploadPP.layer.cornerRadius = 0.5 * BtnUploadPP.bounds.size.width
        BtnUploadPP.clipsToBounds = true
        
        
        self.TxtFieldEmrgNum.delegate = self
        self.TxtFieldEmrgNum.placeholder = "Emergency Number"
        self.TxtFieldEmail.delegate = self
        self.TxtFieldEmail.placeholder = "Email"
        self.TxtFieldPhone.delegate = self
        self.TxtFieldPhone.placeholder = "Phone"
        self.TxtFieldPassword.delegate = self
        self.TxtFieldPassword.placeholder = "Password"
        self.TxtFieldUserName.delegate = self
        self.TxtFieldUserName.placeholder = "User anem"
        
        self.ScrollView.contentSize =  CGSize(width: self.view.frame.size.width , height: 900)

    }

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
}
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func DawnloadImage(url : String) -> UIImage   {
        
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)!
    }
    
    
    func SignupWithAlamofire(user : UserModel) {
        
        let parameters : Parameters = [
        "name" : user.name ,
        "password" : user.password ,
        "phone" :   user.phone ,
        "email" :   user.email ,
        "emergencyNo" : user.emergencyNo ,
        ]
        
        let URL =  "https://safty.herokuapp.com/api/v1/signup"
    
        let imageData = UIImagePNGRepresentation(self.PPImage)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
         let data = imageData
            multipartFormData.append(data!, withName: "img", fileName: "ProfilePicture.png", mimeType: "image/png")
            
            
            
        }, usingThreshold: UInt64.init(), to: URL, method: .post) { (result) in
            print (result)
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { (responseData) -> Void in
                    if((responseData.result.value) != nil) {
                        let json = JSON(responseData.result.value!)
                      
                      //  print ("swiftyJSONVar\(swiftyJsonVar)")
                        /*  let json = JSON(data)
                         let name = json["user"]["name"] */
                        
                        let name  = json["user"]["name"].stringValue
                        let phone = json["user"]["phone"].stringValue
                        let email = json["user"]["email"].stringValue
                        let id    = json["user"]["id"].stringValue
                        let imgString   = json["user"]["img"].stringValue
                            
                        let Token = json["token"].stringValue
                        
                        let imgAsImage = self.DawnloadImage(url: imgString)
                        let imageData: Data = UIImagePNGRepresentation(imgAsImage)!
                            
                            
                        let CurrUser = UserModel(name: name, password: "", phone: phone, email: email, img: imageData, emergencyNo: "" , id: "\(id)" , token: Token)
                            
                            print("THENEWSIGNUPUSER = \(CurrUser)")
                            
                            if let encoded = try? JSONEncoder().encode(CurrUser) {
                             UserDefaults.standard.set(encoded, forKey: "kUser")
                        
                    }
                }
                    
                    if let err = responseData.error{
                        
                        print(err)
                        return
                    }
                    
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                
            }
        }
        
    }
    
    
    ///////////// Pick a PP
    
    ////////////////////
    
    func PickImages(completionPicking : @escaping (_ finishedPicking: Bool) -> ()) {
        
        // create an instance
        let vc = BSImagePickerViewController()
        
        //display picture gallery
        self.bs_presentImagePickerController(vc, animated: true,
        select: { (asset: PHAsset) -> Void in
           
            
            
            
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            
            
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
            
            self.SelectedAssets.removeAll()
            self.PhotoArray.removeAll()
            
        }, finish: { (assets: [PHAsset]) -> Void in
            // User finished with these assets
        
            for i in 0..<assets.count
            {
                self.SelectedAssets.append(assets[i])
            }
            completionPicking(true)
            
            if self.SelectedAssets.count == 0{
            }else{
                self.convertAssetToImages()
            
            }
            
        }, completion: nil)
        
    }
    
    ///////////
    
    func convertAssetToImages() -> Void {
        
        if SelectedAssets.count != 0{
            
            for i in 0..<SelectedAssets.count{
                
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                
                
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                    
                })
                
                let data = UIImageJPEGRepresentation(thumbnail, 0.7)
                let newImage = UIImage(data: data!)
                
                
                self.PhotoArray.append(newImage! as UIImage)
            }
        }
    }
    
    ///////////// Pick a PP End
    
   /* var AcceptTerms : Bool = false
    @IBAction func BtnActAccTerms(_ sender: Any) {
        if AcceptTerms == false {
             BtnAcceptTerms.setImage(#imageLiteral(resourceName: "check-symbol"), for: .selected)
        } else {
            BtnAcceptTerms.setImage( nil,for: .disabled)
        }
    }*/
  
    @IBAction func BtnActUploadPP(_ sender: Any) {
        
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.PPImage = image
        }
    }
    
    
    @IBAction func BtnActLogin(_ sender: Any) {
        
        let imageData: Data = UIImagePNGRepresentation(PhotoArray.first!)!
        
        let NewUser = UserModel(name:  TxtFieldUserName.text!, password: TxtFieldPassword.text!, phone: TxtFieldPhone.text!, email: TxtFieldEmail.text!, img: imageData
            , emergencyNo: TxtFieldEmrgNum.text!, id: "" ,token: "")
        SignupWithAlamofire(user: NewUser)
        
    }
}
