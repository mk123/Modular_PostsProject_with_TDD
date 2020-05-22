//
//  DataModels.swift
//  Posts
//
//  Created by Manjeet Kumar on 20/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation

public struct PostModel: Codable {
    var id: Int?
    var userId: Int?
    var title: String?
    var body: String?
    
    public init(id: Int?, userId: Int?, title: String?, body: String?) {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
    }
}

public struct CommentModel: Codable {
    var id: Int?
    var postId: Int?
    var name: String?
    var email: String?
    var body: String?
    
    public init(id: Int?, postId: Int?, name: String?, email: String?, body: String?) {
        self.id = id
        self.postId = postId
        self.name = name
        self.email = email
        self.body = body
    }
}
