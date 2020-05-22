//
//  PostsTests.swift
//  PostsTests
//
//  Created by Manjeet Kumar on 19/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import XCTest
@testable import Posts

class PostsListViewControllerTests: XCTestCase {
    
    let networkManager = MockPostAPI()
    weak var sut: PostsListViewController?
    
    override func tearDown() {
        super.tearDown()
        XCTAssertNil(sut, "Memory leak detected, viewController not released from memeory after teardown.")
    }
    
    func test_load_VC_from_storyBoard() {
        let vc = makeSut()
        XCTAssertNotNil(vc.view)
    }
    
    func test_inject_dependency() {
        let vc = makeSut()
        vc.injectDependency(networkManager: MockPostAPI())
        XCTAssertNotNil(vc.networkManager)
    }
    
    func test_getPosts_with_two_post() {
        let vc = makeSut()
        vc.injectDependency(networkManager: networkManager)
        
        vc.getPosts()
        networkManager.loadPostsCallback?([makePost(), makePost()], true)
        
        XCTAssertEqual(vc.postsList.count, 2)
    }
    
    func test_getPosts_called_from_viewWillAppear() {
        let vc = makeSut()
        vc.injectDependency(networkManager: networkManager)
        
        vc.viewWillAppear(false)
        networkManager.loadPostsCallback?([makePost()], true)
        
        XCTAssertEqual(vc.postsList.count, 1)
    }
    
    func test_postsTableView_rowCount() {
        var vc = makeSut(posts: [])
        XCTAssertEqual(vc.postsTableView.numberOfRows(inSection: 0), 0)
        
        vc = makeSut(posts: [makePost()])
        XCTAssertEqual(vc.postsTableView.numberOfRows(inSection: 0), 1)
        
        vc = makeSut(posts: [makePost(), makePost()])
        XCTAssertEqual(vc.postsTableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_postsTableViewCell_with_two_posts() {
        let vc = makeSut(posts: [makePost(title: "T1", body: "B1"), makePost(title: "T2", body: "B2")])
        
        XCTAssertEqual(vc.postsTableView.title(at: 0), "T1")
        XCTAssertEqual(vc.postsTableView.body(at: 0), "B1")
        
        XCTAssertEqual(vc.postsTableView.title(at: 1), "T2")
        XCTAssertEqual(vc.postsTableView.body(at: 1), "B2")
    }
    
    // MARK:- Helper functions
    
    func makeSut() -> PostsListViewController {
        let vc = UIStoryboard.postsListViewController()
        sut = vc
        return vc
    }
    
    func makeSut(posts: [PostModel]) -> PostsListViewController {
        let sut =  makeSut()
        sut.injectDependency(networkManager: networkManager)
        sut.getPosts()
        networkManager.loadPostsCallback?(posts, true)
        _ = sut.view
        return sut
    }
    
    func makePost(id: Int = 1, userId: Int = 1, title: String = "Title", body: String = "Body") -> PostModel {
        return PostModel(id: id, userId: userId, title: title, body: body)
    }
    
}

private extension UITableView {
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
    
    func body(at row: Int) -> String? {
        return cell(at: row)?.detailTextLabel?.text
    }
}
