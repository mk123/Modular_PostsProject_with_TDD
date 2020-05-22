//
//  CommentsApiProtocol.swift
//  Posts
//
//  Created by Manjeet Kumar on 20/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation

public protocol CommentsApiProtocol {
    typealias GetCommentsCompletion = (_ comments: [CommentModel], _ success: Bool) -> ()
    
    func getComments(postID: Int, completion: @escaping GetCommentsCompletion)
}
