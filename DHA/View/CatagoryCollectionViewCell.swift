//
//  CatagoryCollectionViewCell.swift
//  DHA
//
//  Created by Sayed Abdo on 11/28/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class CatagoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImgViewHazardType: UIImageView!
    @IBOutlet weak var ImgViewHazardName: UITextField!
    
    
    func configureCell(HazardImage : UIImage , HazardName : String)
    {
        ImgViewHazardType.image = HazardImage
        ImgViewHazardName.text = HazardName
        
    }
}
