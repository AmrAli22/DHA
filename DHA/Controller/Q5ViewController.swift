//
//  Q5ViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/9/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class Q5ViewController: UIViewController , UITextFieldDelegate  {

    
    var ReportDetailsArr = [DetaildReport]()
    var TestRepoArr = [String:AnyObject]()
    
    @IBOutlet weak var BtnYes: CheckBox!
    @IBOutlet weak var BtnNo: CheckBox!
    @IBOutlet weak var TxtFieldNote: UITextField!
    
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()
     self.TxtFieldNote.isHidden = true
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func BtnYesPressed(_ sender: Any) {
        self.TxtFieldNote.isHidden = true
        self.BtnNo.isChecked = false
        appDelegate.Q5_Answer = "Yes"
        appDelegate.noteOfQ5 = ""
        
        
    }
    @IBAction func BtnnoWaspressed(_ sender: Any) {
          self.TxtFieldNote.isHidden = false
          self.BtnYes.isChecked = false
          appDelegate.Q5_Answer = "No"
        appDelegate.noteOfQ5 = self.TxtFieldNote.text
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func BtnActAddNewRepo(_ sender: Any) {
        
        SendReport(FromConduct: false)
    }
    @IBAction func BtnActSave(_ sender: Any) {
        SendReport(FromConduct: false)
        let alert = UIAlertController(title: "Done", message: "Report Sent", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                self.navigationController?.popToRootViewController(animated: true)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }

    
    @IBAction func BtnActConduct(_ sender: Any) {
        SendReport(FromConduct : true  )
        
        

    }
    
    func SendReport(FromConduct : Bool ){
        
        let decoder = JSONDecoder()
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(UserModel.self, from: _CurrentUser!)
       // print ("\(CurrentUser)")
        let CurrentUserToken = CurrentUser?.token
        
        
        var  bearer = "Bearer "
        bearer += CurrentUserToken!
        
          let url = "https://safty.herokuapp.com/api/v1/category/\(appDelegate.CatId!)/reports"
        
        let header : [String: String] = [
            "Authorization" : bearer ,
            "Content-Type" : "application/json"
        ]
        
        let Parametres  = [
            "name" : appDelegate.name ,
            "Date" : appDelegate.Date ,
            "Time" : appDelegate.Time ,
            "Q1_Answer" : appDelegate.Q1_Answer! ,
            "Q3_Answer" : appDelegate.Q3_Answer! ,
            "valueOfQ3" : appDelegate.valueOfQ3! ,
            "Q5_Answer"  : appDelegate.Q5_Answer! ,
            "noteOfQ5"  : appDelegate.noteOfQ5! ,
            "location"  : appDelegate.location! ,
            "id"        : appDelegate.CatId!
            ] as [String : Any]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            var TestQ2Answer = [String]()
            TestQ2Answer = self.appDelegate.Q2_Answer
            for Next in TestQ2Answer {
               multipartFormData.append("\(Next)".data(using: String.Encoding.utf8)!, withName: "Q2_Answer" as String)
            }
            
            
            var TestQ4Answer = [String]()
            TestQ4Answer = self.appDelegate.Q4_Answer
            for Next in TestQ4Answer {
                multipartFormData.append("\(Next)".data(using: String.Encoding.utf8)!, withName: "Q4_Answer" as String)
                
            }
            
            print(TestQ2Answer)
            print(TestQ4Answer)
            
           for (key, value) in Parametres {
            
             multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
             print("\(key)\(value)")
                
             }
            for image in self.appDelegate.img {
                
                let imageData : Data = UIImagePNGRepresentation(image)!
                multipartFormData.append(imageData, withName: "img", fileName: "ProfilePicture.png", mimeType: "image/png")
                
                }
             } ,
                         usingThreshold:UInt64.init(),
                         to:url,
                         method:.post,
                         headers : header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { responseData in
                                  
                                /////
                                    print (responseData)
                                /////
                                    
                                    let swiftyJsonVar = JSON(responseData.result.value!)
                                  
                                    //////
                                    
                                    if FromConduct == true {

                                        let  _title =  (swiftyJsonVar["title"].stringValue)
                                        
                                        print(_title)
                                            let StroyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                                        let vc =  StroyBoard.instantiateViewController(withIdentifier: "FullReportViewController") as? FullReportViewController
                                             vc?.FromConduct = true
                                            vc?.RepoNameFromConduc = _title
                                        self.present(vc!, animated: true, completion: nil )
                                            
                                        }
                                  
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        })
        
        ///////////
        
    }//ENDOFFUNCUPLOAD
}
