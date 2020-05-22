//
//  CommentsListVC.swift
//  Posts
//
//  Created by Manjeet Kumar on 20/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation
import UIKit

class CommentsListViewController: UIViewController {
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    private(set) var postID: Int!
    private(set) var networkManager: CommentsApiProtocol!
    
    private(set) var commentsList: [CommentModel] = []
    
    func injectDependency(postID: Int,
                       networkManager: CommentsApiProtocol) {
        self.postID = postID
        self.networkManager = networkManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getComments()
    }
    
    func getComments() {
        networkManager.getComments(postID: self.postID, completion: {
            [weak self] (comments, success) in
            guard let self = self else { return }
            if success {
                self.commentsList = comments
            } else {
                self.showError(message: "Error loading comments")
            }
        })
    }
    
    func showError(message: String?) {
        print("Error: ", message)
    }
}

extension CommentsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier) as? CommentTableViewCell else {
            return UITableViewCell()
        }
        let commentData = commentsList[indexPath.row]
        cell.configCell(comment: commentData)
        return cell
    }
}

class CommentTableViewCell: UITableViewCell {
    static let identifier = "CommentTableViewCell"
    
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    func configCell(comment: CommentModel) {
        lblBody.text = comment.body
        lblName.text = "By: \(comment.name ?? "No Name")"
    }
}
