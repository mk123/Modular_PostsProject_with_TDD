//
//  PostsApiProtocol.swift
//  Posts
//
//  Created by Manjeet Kumar on 20/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation

public protocol PostsApiProtocol {
    typealias LoadPostCompletion = (_ posts: [PostModel], _ success: Bool) -> ()
    
    func loadPosts(completion: @escaping LoadPostCompletion)
}
