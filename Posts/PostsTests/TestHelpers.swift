//
//  Helpers.swift
//  PostsTests
//
//  Created by Manjeet Kumar on 21/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation
import Posts
import UIKit

extension UITableView {
    func cell(at row: Int, for section: Int = 0) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: section))
    }
}

class MockPostAPI: PostsApiProtocol {
    var loadPostsCallback: PostsApiProtocol.LoadPostCompletion?
    
    func loadPosts(completion: @escaping PostsApiProtocol.LoadPostCompletion) {
        self.loadPostsCallback = completion
    }
}

class MockCommentsAPI: CommentsApiProtocol {
    var getCommentsCallback: CommentsApiProtocol.GetCommentsCompletion?
    var postID: Int?
    
    func getComments(postID: Int, completion: @escaping CommentsApiProtocol.GetCommentsCompletion) {
        self.postID = postID
        self.getCommentsCallback = completion
    }
}


