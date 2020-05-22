//
//  DataModels.swift
//  Users
//
//  Created by Manjeet Kumar on 21/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation

public struct UserModel {
    var name: String?
    var email: String?
    
    public init(name: String?, email: String?) {
        self.name = name
        self.email = email
    }
}
