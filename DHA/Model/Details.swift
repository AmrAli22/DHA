//
//  Details.swift
//  DHA
//
//  Created by Sayed Abdo on 12/19/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
struct DetailsModel {
    
    var img : [UIImage]
    var PDF : [Data]
    var Vedio = [Data]()
    var Voice = [Data]()
    var Q2_Answer = [String]()
    var Q4_Answer = [String]()
    var Q1_Answer : String?
    var Q3_Answer : String?
    var valueOfQ3 : String?
    var Q5_Answer : String?
    var noteOfQ5  : String?
    var id        : Int?
    var Catagory  : String?
    
    init( _img : [UIImage]? , _PDF : [Data]?  , _Vedio  :[Data]? , _Voice : [Data]?  , _Q2_Answer : [String]? , _Q4_Answer : [String]?
        , _Q1_Answer : String? , _Q3_Answer : String? , _valueOfQ3 : String? = nil
        ,_Q5_Answer : String? , _noteOfQ5  : String? , _id : Int? , _Catagory : String? ) {
        self.img =  _img!
        self.PDF = _PDF!
        self.Vedio = _Vedio!
        self.Voice = _Voice!
        self.Q2_Answer = _Q2_Answer!
        self.Q4_Answer = _Q4_Answer!
        self.Q1_Answer = _Q1_Answer
        self.Q3_Answer = _Q3_Answer
        self.valueOfQ3 = _valueOfQ3
        self.Q5_Answer = _Q5_Answer
        self.noteOfQ5 = _noteOfQ5
        self.id       = _id
        self.Catagory = _Catagory
        
        
        
        
    }
    
    
    
}
