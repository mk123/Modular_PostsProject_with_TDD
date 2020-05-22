//
//  CommentsListViewControllerTests.swift
//  PostsTests
//
//  Created by Manjeet Kumar on 21/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation
import XCTest
@testable import Posts

class CommentsListViewControllerTests: XCTestCase {
    
    weak var sut: CommentsListViewController?
    var networkManager = MockCommentsAPI()
    
    override func tearDown() {
        super.tearDown()
        XCTAssertNil(sut, "Memory leak detected, viewController not released from memeory after teardown.")
    }
    
    func test_load_controller_from_storyBoard() {
        let vc = makeSut()
        
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.view)
    }
    
    func test_inject_dependency() {
        let vc = makeSut()
        
        vc.injectDependency(postID: 1, networkManager: networkManager)
        
        XCTAssertEqual(vc.postID, 1)
        XCTAssertNotNil(vc.networkManager)
    }
    
    func test_getComments_with_two_comments() {
        let vc = makeSut()
        vc.injectDependency(postID: 1, networkManager: networkManager)
        
        vc.getComments()
        networkManager.getCommentsCallback?([makeComment(), makeComment()], true)
        
        XCTAssertEqual(networkManager.postID, 1)
        XCTAssertEqual(vc.commentsList.count, 2)
    }
    
    func test_getComments_called_from_viewWillAppear() {
        let vc = makeSut()
        vc.injectDependency(postID: 1, networkManager: networkManager)
        
        vc.viewWillAppear(false)
        networkManager.getCommentsCallback?([makeComment()], true)
        
        XCTAssertEqual(networkManager.postID, 1)
        XCTAssertEqual(vc.commentsList.count, 1)
    }
    
    func test_commentsTableView_rowCount() {
        var vc = makeSut([])
        XCTAssertEqual(vc.commentsTableView.numberOfRows(inSection: 0), 0)
        
        vc = makeSut([makeComment(), makeComment()])
        XCTAssertEqual(vc.commentsTableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_tableView_with_two_commentCell() {
        let vc = makeSut([makeComment(name: "N1", body: "B1"),
                          makeComment(name: "N2", body: "B2")])
        
        XCTAssertEqual(vc.commentsTableView.commentBody(at: 0), "B1")
        XCTAssertEqual(vc.commentsTableView.commentName(at: 0), "By: N1")
        
        XCTAssertEqual(vc.commentsTableView.commentBody(at: 1), "B2")
        XCTAssertEqual(vc.commentsTableView.commentName(at: 1), "By: N2")
    }
    
    //MARK:- Helper functions
    
    func makeSut() -> CommentsListViewController {
        let vc = UIStoryboard.commentsListViewController()
        sut = vc
        return vc
    }
    
    func makeSut(_ comments: [CommentModel]) -> CommentsListViewController {
        let vc = makeSut()
        vc.injectDependency(postID: 1, networkManager: networkManager)
        vc.getComments()
        networkManager.getCommentsCallback?(comments, true)
        _ = vc.view
        return vc
    }
    
    func makeComment(id: Int = 1, postID: Int = 1, name: String = "C",
                     email: String = "E", body: String = "B") -> CommentModel {
        return CommentModel(id: id, postId: postID, name: name, email: email, body: body)
    }
}

private extension UITableView {
    func commentBody(at row: Int) -> String? {
        return (cell(at: row) as? CommentTableViewCell)?.lblBody.text
    }
    
    func commentName(at row: Int) -> String? {
        return (cell(at: row) as? CommentTableViewCell)?.lblName.text
    }
}
