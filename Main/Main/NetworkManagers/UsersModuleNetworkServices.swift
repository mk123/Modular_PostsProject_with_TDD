//
//  UsersModuleNetworkManager.swift
//  Main
//
//  Created by Manjeet Kumar on 21/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation
import Users

class UsersModuleNetworkManager: UsersModuleNetworkManagerProtocol {
    var usersService: UsersApiProtocol? = UsersApiService()
}

class UsersApiService: UsersApiProtocol {
    func getUsers(completion: @escaping UsersApiProtocol.GetUsersCompletion) {
        let demoUser = UserModel(name: "User1", email: "Email@user1.com")
        completion([demoUser], true)
    }
}
