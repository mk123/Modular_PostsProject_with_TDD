//
//  UIStoryBoard_Extension.swift
//  Users
//
//  Created by Manjeet Kumar on 21/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static func getStoryBoard(name: String, bundle: Bundle) -> UIStoryboard {
        return UIStoryboard.init(name: name, bundle: bundle)
    }
    
    static func loadViewController(from storyBoardName: String,
                                   bundle: Bundle,
                                   identifier: String) -> UIViewController {
        let storyBoard =  getStoryBoard(name: storyBoardName, bundle: bundle)
        return storyBoard.instantiateViewController(withIdentifier: identifier)
    }
    
    static func usersListViewController() -> UsersListViewController {
        let vc = loadViewController(from: "Users",
                                    bundle: Bundle(for: UsersListViewController.self),
                                    identifier: "UsersListViewController")
        return vc as! UsersListViewController
    }
}
