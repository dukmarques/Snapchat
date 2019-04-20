//
//  User.swift
//  Snapchat
//
//  Created by Eduardo on 20/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import Foundation

class User {
    var email: String
    var name: String
    var uid: String
    
    init(email: String, name: String, uid: String) {
        self.email = email
        self.name = name
        self.uid = uid
    }
}
