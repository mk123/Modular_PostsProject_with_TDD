//
//  UIStoryBoard_Extension.swift
//  Posts
//
//  Created by Manjeet Kumar on 20/05/20.
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
    
    static func postsListViewController() -> PostsListViewController {
        let vc = loadViewController(from: "Posts",
                                    bundle: Bundle(for: PostsListViewController.self),
                                    identifier: "PostsListViewController")
        return vc as! PostsListViewController
    }
    
    static func commentsListViewController() -> CommentsListViewController {
        let vc = loadViewController(from: "Posts",
                                    bundle: Bundle(for: CommentsListViewController.self),
                                    identifier: "CommentsListViewController")
        return vc as! CommentsListViewController
    }
}
