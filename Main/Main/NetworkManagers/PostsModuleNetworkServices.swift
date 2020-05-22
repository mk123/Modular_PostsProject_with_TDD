//
//  PostsModuleNetworkManager.swift
//  Main
//
//  Created by Manjeet Kumar on 21/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation
import Posts

class PostsModuleNetworkManager: PostsModuleNetworkManagerProtocol {
    var postsService: PostsApiProtocol? = PostsApiService()
    var commentsService: CommentsApiProtocol? = CommentsApiService()
}

class PostsApiService: PostsApiProtocol {
    func loadPosts(completion: @escaping PostsApiProtocol.LoadPostCompletion) {
        let demoPost = PostModel(id: 1, userId: 1, title: "POST 1", body: "Body of POST")
        completion([demoPost], true)
    }
}

class CommentsApiService: CommentsApiProtocol {
    func getComments(postID: Int, completion: @escaping CommentsApiProtocol.GetCommentsCompletion) {
        let demoComment = CommentModel(id: 1, postId: 1, name: "User1", email: "Email@user1.com", body: "Body of Comment")
        completion([demoComment], true)
    }
}
