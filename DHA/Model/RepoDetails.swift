//
//  RepoDetails.swift
//  DHA
//
//  Created by Sayed Abdo on 12/11/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import Foundation
struct DetaildReport {
    let Title : String
    let Details : [AnyObject]
    let Date : String
    let Time : String
    let Location : String
    
   
    
    init(_title : String  , _Date : String , _Time : String , _Location : String , _Details : [AnyObject] ) {
        Title = _title
        Details = _Details
        Date = _Date
        Time = _Time
        Location = _Location
    }
}
