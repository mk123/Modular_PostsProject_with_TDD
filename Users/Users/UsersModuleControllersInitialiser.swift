//
//  UsersModuleControllersInitialiser.swift
//  Users
//
//  Created by Manjeet Kumar on 21/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation
import UIKit

public class UsersModuleControllersInitialiser {
    public static var shared: UsersModuleControllersInitialiser?
    
    var networkManager: UsersModuleNetworkManagerProtocol!
    public init(networkManager: UsersModuleNetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    public func getUsersListViewController() -> UsersListViewController? {
        guard let usersNetworkManager = networkManager.usersService else {
            return nil
        }
        let vc = UIStoryboard.usersListViewController()
        vc.injectDependency(networkManager: usersNetworkManager)
        return vc
    }
}
