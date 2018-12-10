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

    
    @IBOutlet weak var BtnYes: CheckBox!
    @IBOutlet weak var BtnNo: CheckBox!
    @IBOutlet weak var TxtFieldNote: UITextField!
    
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    ///////ReportAssembly
    
  /*  let ReportCatID = CollectOrRepoViewController(nibName: "CollectOrRepoViewController", bundle: nil).ReceivedCatagoryID
    let ReportName = StartRepViewController(nibName: "StartRepViewController", bundle: nil).ReportName
    let ReportDate = StartRepViewController(nibName: "StartRepViewController", bundle: nil).ReportDate
    let ReportTime = StartRepViewController(nibName: "StartRepViewController", bundle: nil).ReportTime
    let ReportLocation = StartRepViewController(nibName: "StartRepViewController", bundle: nil).location
    let PhotoArray = StartRepViewController(nibName: "StartRepViewController", bundle: nil).PhotoArray
    let Q1Answer = Q1ViewController(nibName: "Q1ViewController", bundle: nil).TxtFieldAnswer.text
    let Q2Answer = Q2ViewController(nibName: "Q2ViewController", bundle: nil).Q2Answers
    let Q3Answer = Q3ViewController(nibName: "Q3ViewController", bundle: nil).Q3Answer
    let Q3AnswerType = Q3ViewController(nibName: "Q3ViewController", bundle: nil).Q3AnswerType
    let Q4Answer = Q4ViewController(nibName: "Q4ViewController", bundle: nil).Q4Answer
    var Q5Answer = ""
    var Q5Note = "" */
     ///////ReportAssembly
    
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
   
    @IBAction func BtnActConduct(_ sender: Any) {
    }
    @IBAction func BtnActSave(_ sender: Any) {
        SendReport()
    }

    
    func SendReport(){
        
        let decoder = JSONDecoder()
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(UserModel.self, from: _CurrentUser!)
        print ("\(CurrentUser)")
        let CurrentUserToken = CurrentUser?.token
        
        
        
        var  bearer = "Bearer "
        bearer += CurrentUserToken!
        
          let url = "https://safty.herokuapp.com/api/v1/category/\(appDelegate.CatId!)/reports"
        
        let header : [String: String] = [
            "Authorization" : bearer ,
            "Content-Type" : "application/json"
        ]
        
        let Parametres  = [
            //"Q2_Answer" :   appDelegate.Q2_Answer ,
            //"Q4_Answer" : appDelegate.Q4_Answer  ,
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
            ]
        
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
                multipartFormData.append(imageData, withName: "img")
                
                }
             } ,
                         usingThreshold:UInt64.init(),
                         to:url,
                         method:.post,
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
}
