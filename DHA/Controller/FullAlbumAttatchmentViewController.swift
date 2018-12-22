//
//  FullAlbumAttatchmentViewController.swift
//  DHA
//
//  Created by Sayed Abdo on 12/20/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class FullAlbumAttatchmentViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    let CellID = "FullReportAttatchment"
    
    @IBOutlet weak var collectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return   self.AlbumImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as? AlbumImagesCollectionViewCell
        
      cell?.ConfigurationCell(img: AlbumImages[indexPath.row])
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  5
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    

    var AlbumImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
