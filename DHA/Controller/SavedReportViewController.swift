//
//  SavedReportViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/11/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SavedReportViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  ReportDetailsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetaildRepoCell", for: indexPath) as? RepoDetailsTableViewCell
        let CurrentRepo = self.ReportDetailsArr[indexPath.row]
        cell?.ConfigureCell(_RepoName: CurrentRepo.Title,
                            _RepoDate: CurrentRepo.Date,
                            _RepoTime: CurrentRepo.Time,
                            _RepoLoc: CurrentRepo.Location
        )
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let i = TableView.indexPath(for: cell)!.row
            if segue.identifier == "GoFullRepo" {
                let vc = segue.destination as! FullReportViewController
                vc.CurrentRepo.insert(ReportDetailsArr[i], at: 0)
                vc.DetailsArr = ReportDetailsArr[i].Details
            }
        }
    }
    

    @IBOutlet weak var TableView: UITableView!
    
    var ReportDetailsArr = [DetaildReport]()
    var TestRepoArr = [[String:AnyObject]]()

    var CameFromConduct : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FetchReportsNames()
  
        if self.CameFromConduct == true {
            
            TableView.delegate = self
            TableView.dataSource = self
            
            TableView.reloadData()
            let rowToSelect:IndexPath = IndexPath(row: 0, section: 0)
            let Tablev =  self.TableView
            self.TableView.selectRow(at: rowToSelect, animated: true, scrollPosition: UITableViewScrollPosition.top)
            
            self.TableView.delegate!.tableView!( Tablev! , didSelectRowAt: rowToSelect)
            
            
        }else{
            TableView.delegate = self
            TableView.dataSource = self
            
            TableView.reloadData()
             self.TableView.rowHeight = 100
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func FetchReportsNames()
    {
        let decoder = JSONDecoder()
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(UserModel.self, from: _CurrentUser!)
        let CurrentUserToken = CurrentUser?.token
        let CurrentUserId = CurrentUser?.id
        
        var  bearer = "Bearer "
        bearer += CurrentUserToken!
        
        let url = "https://safty.herokuapp.com/api/v1/users/\(CurrentUserId!)/reports"
        print (url)
        let header : [String: String] = [
            "Authorization" : bearer ,
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (responseData) -> Void in
           // print (responseData)
    
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                //////
              
                if let resData = swiftyJsonVar.arrayObject {
                 //   print("resData = \(resData)")
                    self.TestRepoArr = resData as! [[String:AnyObject]]
                 //   print ("TestRepArr\(self.TestRepoArr)")
                    
                    for NextRepo in self.TestRepoArr {
                        
                    let   _title =  (NextRepo["title"] as? String)!
                    let  _Details = (NextRepo["details"] as? [AnyObject])!
                    let   _Date =  _Details[0]["Date"] as? String
                    let  _Time = _Details[0]["Time"] as? String
                    let _Location = _Details[0]["location"] as? String
                      
                        let newDetaildRepo = DetaildReport.init(
                            _title: _title
                            , _Date: _Date!
                            , _Time: _Time!
                            , _Location: _Location!
                            , _Details: _Details
                        )
                        
                    
                      //  print("NextRepo\(NextRepo)")
                        self.ReportDetailsArr.append(newDetaildRepo)
                      //  print ("EventArrayInFunction\(self.ReportDetailsArr)")
                    }
                    self.TableView.reloadData()
                    print ("EventArrayInFunction\(self.ReportDetailsArr)")
                }
                
                //////
           
            }
        }
    }//EndFunc
}//EndClass
