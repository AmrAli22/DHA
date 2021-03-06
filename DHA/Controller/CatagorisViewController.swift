//
//  CatagorisViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 11/27/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CatagorisViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    var CatagoryArray = [CatagoryModel]()
    
    
    let cellid = "CatagoriesCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.CatagoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as? CatagoryCollectionViewCell
        
        print(self.CatagoryArray)
        
        cell?.configureCell(HazardImage: self.DawnloadImage(url:  CatagoryArray[indexPath.row].img )                                            , HazardName: CatagoryArray[indexPath.row].name)
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UICollectionViewCell,
            let indexPath = self.collectionView.indexPath(for: cell) {
        
            
            appDelegate.CatagorisArr = self.CatagoryArray
            
            appDelegate.CatId = CatagoryArray[indexPath.row].id
            appDelegate.CatName = CatagoryArray[indexPath.row].name
        }
    }
    

    var testCatArray = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        GetGatagorisWithAlamoFire()
       /*
        let Fire = CatagoryModel.init(_name: "fire", _img : UIImage(named:"fire")!, _id: "1")
        let antibiotic = CatagoryModel.init(_name: "antibiotic", _img : UIImage(named:"antibiotic")!, _id: "2")
        let flash = CatagoryModel.init(_name: "flash", _img : UIImage(named:"flash")!, _id: "3")
        let molecule = CatagoryModel.init(_name: "molecule", _img : UIImage(named:"molecule")!, _id: "4")
        let noise = CatagoryModel.init(_name: "noise", _img : UIImage(named:"noise")!, _id: "5")
        let nuclearEnergy = CatagoryModel.init(_name: "nuclear-energy", _img : UIImage(named:"nuclear-energy")!, _id: "6")
        let pressure = CatagoryModel.init(_name: " pressure ", _img : UIImage(named:"pressure-indicator")!, _id: "7")
        let chemical = CatagoryModel.init(_name: " chemical ", _img : UIImage(named:"test")!, _id: "7")
        let thermo = CatagoryModel.init(_name: " thermo ", _img : UIImage(named:"thermometer")!, _id: "8")
        
        self.CatagoryArray.append(Fire)
        self.CatagoryArray.append(antibiotic)
        self.CatagoryArray.append(flash)
        self.CatagoryArray.append(molecule)
        self.CatagoryArray.append(noise)
        self.CatagoryArray.append(nuclearEnergy)
        self.CatagoryArray.append(pressure)
        self.CatagoryArray.append(chemical)
        self.CatagoryArray.append(thermo)
        */
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
    
    @IBAction func BtnMakeEmergCall(_ sender: Any) {
    /*
        let decoder = JSONDecoder()
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(UserModel.self, from: _CurrentUser!)
        let CurrentUserEmergencyNum = CurrentUser?.emergencyNo
        
        guard let phoneUrl: NSURL = NSURL(string: "telprompt:\(CurrentUserEmergencyNum)")!
            else{
            let alert = UIAlertController(title: "Alert", message: "No Emergency Phone Found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
        }
        print(phoneUrl)
        if UIApplication.shared.canOpenURL(phoneUrl as URL ) {
            UIApplication.shared.openURL(phoneUrl as URL)
        
        }else{
            print("CantOpenURL")
        } */
    }
        
     /*   extension UIViewController {
            
            func alert(message: String, title: String = "") {
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
            }
        } */
    func GetGatagorisWithAlamoFire(){
        
        let decoder = JSONDecoder()
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(UserModel.self, from: _CurrentUser!)
        print ("\(CurrentUser)")
        let CurrentUserToken = CurrentUser?.token

        var  bearer = "Bearer "
        bearer += CurrentUserToken!
        
        let url = "https://safty.herokuapp.com/api/v1/category"
       
        let header : [String: String] = [
            "Authorization" : bearer ,
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                
                let swiftyJsonVar = JSON(responseData.result.value!).arrayObject
                
                    self.testCatArray = swiftyJsonVar as! [[String:AnyObject]]
                        print("test\(self.testCatArray)")
                    for NextCat in self.testCatArray {
                     //   let imageData: Data = UIImagePNGRepresentation(imgAsImage)! /*self.adc_role_id = String(describing: res["adc_role_id"])

                        let NewCatagory = CatagoryModel.init(_name: NextCat["name"] as! String,
                                                             _img: NextCat["img"] as! String,
                                                             _id: NextCat["id"] as! Int
                                                    )
                        self.CatagoryArray.append(NewCatagory)
                        
                  print ("new\(NewCatagory)")
                }
                 self.collectionView.reloadData()
            }
        }
    }
}
