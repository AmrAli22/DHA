//
//  CatagoryModel.swift
//  DHA
//
//  Created by Sayed Abdo on 11/28/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit


struct CatagoryModel {

    var name : String
    var img : UIImage
    var id : String
    
    init(_name : String , _img : UIImage , _id : String ) {
        name = _name
        img = _img
        id = _id
    }
    
}
