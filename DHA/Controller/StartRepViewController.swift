//
//  StartRepViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/7/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

class StartRepViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var TxtFieldLocation: UITextField!
    @IBOutlet weak var TxtFieldRepName: UITextField!
    @IBOutlet weak var DatePickerRepDate: UIDatePicker!
    
    var SelectedAssets = [PHAsset]()
    var PhotoArray = [UIImage]()
    var EmptyData = [Data]()
    var ReportDate = ""
    var ReportTime = ""
    var ReportName = ""
    var location   = ""
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
      
        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func BtnStartReportAct(_ sender: Any) {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        self.ReportDate = dateFormatter.string(from: self.DatePickerRepDate.date)
        
        let ReportTimeHour = self.DatePickerRepDate.calendar.component(.hour, from: self.DatePickerRepDate.date)
        let ReportTimeMin = self.DatePickerRepDate.calendar.component(.minute , from: self.DatePickerRepDate.date)
        self.ReportTime = "\(ReportTimeHour) : \(ReportTimeMin)"
        
        
        
        appDelegate.name = self.TxtFieldRepName.text!
        appDelegate.Date = dateFormatter.string(from: self.DatePickerRepDate.date)
        appDelegate.location = self.TxtFieldLocation.text!
        appDelegate.Time = "\(ReportTimeHour) : \(ReportTimeMin)"
        
        
       
        
    }
    
    @IBAction func BtnActUploadPhotos(_ sender: Any) {
        
        
        self.SelectedAssets.removeAll()
        self.PhotoArray.removeAll()
        PickImages { (DonePicking) in
            if DonePicking {
                print ("PhotosArrCount\(self.PhotoArray.count)")
                
                
            }
        }
        
    }//EndBTNACTUplioad

    @IBAction func BtnActRecord(_ sender: Any) {
    }

    
    
    ///PickImages
     
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
                print("NoSelectedImages")
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
}

