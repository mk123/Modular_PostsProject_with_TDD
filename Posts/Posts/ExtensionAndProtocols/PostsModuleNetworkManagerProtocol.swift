//
//  NetworkManager.swift
//  Posts
//
//  Created by Manjeet Kumar on 20/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation

public protocol PostsModuleNetworkManagerProtocol {
    var postsService: PostsApiProtocol? { get }
    var commentsService: CommentsApiProtocol? { get }
}
