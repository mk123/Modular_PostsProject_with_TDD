//
//  PostsListViewController.swift
//  Posts
//
//  Created by Manjeet Kumar on 20/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import UIKit

public class PostsListViewController: UIViewController {
    
    @IBOutlet weak var postsTableView: UITableView!
    
    private(set) var networkManager: PostsApiProtocol!
    
    private(set) var postsList: [PostModel] = []
    
    func injectDependency(networkManager: PostsApiProtocol) {
        self.networkManager = networkManager
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.dataSource = self
        postsTableView.delegate = self
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPosts()
    }
    
    func getPosts() {
        networkManager.loadPosts(completion: {
            [weak self] (posts, success) in
            guard let self = self else {return}
            if success {
                self.postsList = posts
            } else {
                self.showError(message: "Error fetching posts")
            }
        })
    }
    
    func showError(message: String?) {
        print(message ?? "")
    }
    
}

extension PostsListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        let post = postsList[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }
}

extension PostsListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let postID = postsList[indexPath.row].id else {return}
        guard let vc = PostsModuleControllersInitialiser.shared?.getCommentsVC(postID: postID) else {
            return
        }
        self.present(vc, animated: true, completion: nil)
    }
}
