//
//  UserModel.swift
//  DHA
//
//  Created by AmrAli on 11/25/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import Foundation
import UIKit

struct UserModel : Codable {
    
    var name : String
    var password : String
    var phone : String
    var email : String
    var img : Data
    var emergencyNo : String
    var id : String
    var token : String
    
}
