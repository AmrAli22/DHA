//
//  FullReportViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/12/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FullReportViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var CurrentRepo = [DetaildReport]() ///Getting Name And Date And Location
    
    var DetailsArr = [AnyObject]() // Getting Report FullDetails
    
    var FromConduct : Bool = false
    
    var RepoNameFromConduc : String = ""
    
    var CellDatailsArr = [DetailsModel]()
    
    var TestRepoArr = [[String:AnyObject]]()
    
    @IBOutlet weak var TableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  DetailsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FullReport", for: indexPath) as? FullReportTableViewCell
        let CurrentCellRepo = self.CurrentRepo[0]
        let CurrDetailsCellRepo = self.CellDatailsArr[indexPath.row]
        cell?.ConfigureCell(
                 name: CurrentCellRepo.Title
               , Date: ("\(CurrentCellRepo.Date)" + "\(CurrentCellRepo.Time)")
               , Location: CurrentCellRepo.Location
               , Catogry: CurrDetailsCellRepo.Catagory!
               , Q1: CurrDetailsCellRepo.Q1_Answer!
               , Q2: CurrDetailsCellRepo.Q2_Answer.joined(separator: " ")
               , RiskValue: CurrDetailsCellRepo.Q3_Answer!
               , Q4: CurrDetailsCellRepo.Q4_Answer.joined(separator: " ")
               , Q5: CurrDetailsCellRepo.Q5_Answer!
        )
        return cell!
    }
    
    
    ///////////
    //var ReportDetailsArr = [DetaildReport]()
   //var TestRepoArr = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.rowHeight = self.TableView.frame.height
        if FromConduct{
            GettingOneRepoDetailsFromConduc()
            TableView.reloadData()
        }else{
        
        GettingRepoDetails()
       TableView.reloadData()
      
        }
        
        TableView.delegate = self
        TableView.dataSource = self
        TableView.reloadData()
        
    }
    
    func DawnloadImage(url : String) -> UIImage   {
        
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)!
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let i = TableView.indexPath(for: cell)!.row
            if segue.identifier == "SeeAlbumPhotos" {
                let vc = segue.destination as! FullAlbumAttatchmentViewController
                vc.AlbumImages = self.CellDatailsArr[i].img
            }
        }
    }
    
    
    ////FuncOneRepGetting BEGIN
    func GettingOneRepoDetailsFromConduc(){
        
        let decoder = JSONDecoder()
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(UserModel.self, from: _CurrentUser!)
        // print ("\(CurrentUser)")
        let CurrentUserToken = CurrentUser?.token
        
        var  bearer = "Bearer "
        bearer += CurrentUserToken!
        
        let url = "https://safty.herokuapp.com/api/v1/reports/\(self.RepoNameFromConduc)"
        
        let header : [String: String] = [
            "Authorization" : bearer ,
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
             
                let swiftyJsonVar = JSON(responseData.result.value!)
                print(swiftyJsonVar)
              if let resData = swiftyJsonVar.dictionaryObject  {
                print("resdata\(resData)")
               // self.TestRepoArr = resData as! [[String:AnyObject]]
                
                
              let OnlyReprt =   DetaildReport.init(
                    _title: (resData["title"] as? String)!
                , _Date: (resData["Details"]!["Date"] as? String)!
                , _Time: (self.TestRepoArr[0]["Details"]!["Time"] as? String)!
                , _Location: (self.TestRepoArr[0]["Details"]!["Location"] as? String)!
                , _Details: (self.TestRepoArr[0]["Details"] as? [AnyObject])!
                )
                
                self.CurrentRepo.insert(OnlyReprt, at: 0)
                self.DetailsArr = OnlyReprt.Details
                }
            }///if((responseData.result.value) != nil) END
        }///AlmofireRequest END
    }////FuncOneRepGetting END
    
    func GettingRepoDetails(){
        
        var CurrentImagesArray = [UIImage]()
        
        for Details in self.DetailsArr {
            
            var ImagesArrayAsString = [String]()
            ImagesArrayAsString  = (Details["img"] as? [String])!
            for imgurl in ImagesArrayAsString {
               CurrentImagesArray.append(self.DawnloadImage(url: imgurl))
            }
            
            var Catobj = (Details["category"] as? [String : Any])
            var CatName = Catobj!["name"] as? String
            
            
            let CurrDetailsForCellReport = DetailsModel.init(
                _img: CurrentImagesArray
              , _PDF: (Details["PDF"] as? [Data])!
              , _Vedio: (Details["Vedio"] as? [Data])!
              , _Voice: (Details["Voice"] as? [Data])!
              , _Q2_Answer: (Details["Q2_Answer"] as? [String])!
              , _Q4_Answer: (Details["Q4_Answer"] as? [String])!
              , _Q1_Answer: (Details["Q1_Answer"] as? String)!
              , _Q3_Answer: (Details["Q3_Answer"] as? String)!
              , _Q5_Answer: (Details["Q5_Answer"] as? String)!
              , _noteOfQ5: (Details["noteOfQ5"] as? String)!
              , _id: (Details["id"] as? Int)!
              , _Catagory: CatName)
            
            self.CellDatailsArr.append(CurrDetailsForCellReport)
            TableView.reloadData()

            ImagesArrayAsString.removeAll()
            
        }//ForEachEnd
        TableView.reloadData()
    }//FuncGettingRepoDetailsEnd
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.TableView.frame.height
    }
    
   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

////
}
