//
//  UsersApiProtocol.swift
//  Users
//
//  Created by Manjeet Kumar on 21/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation

public protocol UsersApiProtocol {
    typealias GetUsersCompletion = (_ users: [UserModel],_ success: Bool) -> ()
    
    func getUsers(completion: @escaping GetUsersCompletion)
}
