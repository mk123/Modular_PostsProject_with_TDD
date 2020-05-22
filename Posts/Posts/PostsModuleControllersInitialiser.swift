//
//  PostsControllersInitialiser.swift
//  Posts
//
//  Created by Manjeet Kumar on 20/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation
import UIKit

public class PostsModuleControllersInitialiser {
    public static var shared: PostsModuleControllersInitialiser?
    
    var networkManger: PostsModuleNetworkManagerProtocol!
    
    public init(networkManager: PostsModuleNetworkManagerProtocol) {
        self.networkManger = networkManager
    }
    
    public func getPostsListVC() -> PostsListViewController? {
        guard let postsNetworkManager = networkManger.postsService else {
            return nil
        }
        let vc = UIStoryboard.postsListViewController()
        vc.injectDependency(networkManager: postsNetworkManager)
        return vc
    }
    
    func getCommentsVC(postID: Int) -> CommentsListViewController? {
        guard let commentsNetworkManager = networkManger.commentsService else {
            return nil
        }
        let vc = UIStoryboard.commentsListViewController()
        vc.injectDependency(postID: postID, networkManager: commentsNetworkManager)
        return vc
    }
}
