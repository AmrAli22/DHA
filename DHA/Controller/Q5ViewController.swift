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
class Q5ViewController: UIViewController {

    
    @IBOutlet weak var BtnYes: CheckBox!
    @IBOutlet weak var BtnNo: CheckBox!
    @IBOutlet weak var TxtFieldNote: UITextField!
    
    ///////ReportAssembly
    
    let ReportCatID = CollectOrRepoViewController(nibName: "CollectOrRepoViewController", bundle: nil).ReceivedCatagoryID
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
    var Q5Note = ""
     ///////ReportAssembly
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TxtFieldNote.isHidden = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func BtnActConduct(_ sender: Any) {
    }
    @IBAction func BtnActSave(_ sender: Any) {
    }
    
    func SendReport(){
 
            let decoder = JSONDecoder()
            let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
            let CurrentUser = try? decoder.decode(UserModel.self, from: _CurrentUser!)
            print ("\(CurrentUser)")
            let CurrentUserToken = CurrentUser?.token
        
        
        
            var  bearer = "Bearer "
            bearer += CurrentUserToken!
        
            let url = "https://safty.herokuapp.com/api/v1/category/\(self.ReportCatID)/reports"
        
            let header : [String: String] = [
                "Authorization" : bearer ,
                "Content-Type" : "application/json"
            ]
        
        let Parametres : Parameters = [
            "Q2_Answer" : Q2Answer  ,
            "Q4_Answer" : Q4Answer  ,
        "name" : ReportName ,
        "Date" : ReportDate ,
        "Time" : ReportTime ,
        "Q1_Answer" : Q1Answer ,
        "Q3_Answer" : Q3AnswerType ,
        "valueOfQ3" : Q3Answer ,
       "Q5_Answer"  : Q5Answer ,
      "noteOfQ5"  : Q5Note ,
        "location"  : ReportLocation ,
       "id"        : ReportCatID
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in Parametres {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            let data = imageData
            multipartFormData.append(data, withName: "img", fileName: "ProfilePicture.png", mimeType: "image/png")
            
            
            
        }, usingThreshold: UInt64.init(), to: URL, method: .post) { (result) in
            print (result)
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { (responseData) -> Void in
                    if((responseData.result.value) != nil) {
                        let json = JSON(responseData.result.value!)
                        
                        
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
}
