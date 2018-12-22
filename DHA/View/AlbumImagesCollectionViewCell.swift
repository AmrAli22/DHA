//
//  AlbumImagesCollectionViewCell.swift
//  DHA
//
//  Created by Sayed Abdo on 12/20/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class AlbumImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var AlbumImage: UIImageView!
    
    
    func ConfigurationCell (img : UIImage){
        self.AlbumImage.image = img
    }
    
}
