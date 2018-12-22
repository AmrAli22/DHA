//
//  CollectDataViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/12/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Photos
import BSImagePicker

class CollectDataViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        print(pickerData[row])
        
    }
    

    @IBOutlet weak var DataPicker: UIPickerView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var SelectedAssets = [PHAsset]()
    var PhotoArray = [UIImage]()
    
    var pickerData: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for cat in appDelegate.CatagorisArr
        {
            pickerData.append(cat.name)
        }
        
        
        self.DataPicker.delegate = self
        self.DataPicker.dataSource = self
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func UploadDataCollectionPhotos(_ sender: Any) {
        
        PickImages { (End) in
            if End {
                print ("End")
            }
        }
    }
    
    @IBAction func BtnSaveWasPressed(_ sender: Any) {
        print ("Uploading \(self.PhotoArray) ")
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
