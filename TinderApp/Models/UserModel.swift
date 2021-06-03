//
//  UserModel.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/06/03.
//

import Foundation
import Firebase

class User{
    var email: String
    var name: String
    
    var creditAt: Timestamp
    
    init(dic: [String: Any]) {
        self.email = dic["email"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.creditAt = dic["creditAt"] as? Timestamp ?? Timestamp()
    }
}
