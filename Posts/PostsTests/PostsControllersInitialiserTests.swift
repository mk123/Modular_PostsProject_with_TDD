//
//  PostsControllersInitialiserTests.swift
//  PostsTests
//
//  Created by Manjeet Kumar on 21/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import XCTest
@testable import Posts

class PostsControllersInitialiserTests: XCTestCase {
    
    var networkManager = MockNetworkManager()
    
    func test_getPostsListViewController() {
        let sut = makeSut()
        
        let vc = sut.getPostsListVC()
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc?.networkManager)
    }
    
    func test_getPostsListVC_when_nil_postsApiService() {
        networkManager.postsService = nil
        let sut = makeSut()
        
        let vc = sut.getPostsListVC()
        
        XCTAssertNil(vc)
    }
    
    func test_getCommentsViewController() {
        let sut = makeSut()
        
        let vc = sut.getCommentsVC(postID: 1)
        
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc?.networkManager)
        XCTAssertEqual(vc?.postID, 1)
    }
    
    func test_getCommentsVC_when_nil_commentsApiService() {
        networkManager.commentsService = nil
        let sut = makeSut()
        
        let vc = sut.getCommentsVC(postID: 1)
        
        XCTAssertNil(vc)
    }
    
    //MARK:- Helper functions
    
    func makeSut() -> PostsModuleControllersInitialiser {
        let sut = PostsModuleControllersInitialiser(networkManager: networkManager)
        return sut
    }
    
    class MockNetworkManager: PostsModuleNetworkManagerProtocol {
        var postsService: PostsApiProtocol? = MockPostAPI()
        
        var commentsService: CommentsApiProtocol? = MockCommentsAPI()
    }
}
