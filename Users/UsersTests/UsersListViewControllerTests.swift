//
//  UsersListViewControllerTests.swift
//  UsersTests
//
//  Created by Manjeet Kumar on 21/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import XCTest
@testable import Users
import UIKit

class UsersListViewControllerTests: XCTestCase {
    
    weak var weakSut: UsersListViewController?
    var networkManager = MockUsersApi()
    
    override func tearDown() {
        super.tearDown()
        XCTAssertNil(weakSut, "Memory leak detected, viewController not released from memeory after teardown.")
    }
    
    func test_load_view_controller() {
        let sut = makeSut()
        
        XCTAssertNotNil(sut)
    }
    
    func test_inject_dependency() {
        let sut = makeSut()
        
        sut.injectDependency(networkManager: networkManager)
        
        XCTAssertNotNil(sut.networkManager)
    }
    
    func test_getUsers_with_two_user() {
        let sut = makeSut()
        sut.injectDependency(networkManager: networkManager)
        
        sut.getUsers()
        networkManager.getUsersCallback?([makeUser(), makeUser()], true)
        
        XCTAssertEqual(sut.usersList.count, 2)
    }
    
    func test_getUsers_call_from_viewWillAppear() {
        let sut = makeSut()
        sut.injectDependency(networkManager: networkManager)
        
        sut.viewWillAppear(false)
        networkManager.getUsersCallback?([makeUser(), makeUser()], true)
        
        XCTAssertEqual(sut.usersList.count, 2)
    }
    
    func test_usersTableView_rowCount() {
        var sut = makeSut([])
        XCTAssertEqual(sut.usersTableView.numberOfRows(inSection: 0), 0)
        
        sut = makeSut([makeUser()])
        XCTAssertEqual(sut.usersTableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_usersTableView_with_two_userCell() {
        var sut = makeSut([makeUser(name: "A", email: "B"),
                           makeUser(name: "A1", email: "B1")])
        
        XCTAssertEqual(sut.usersTableView.userName(at: 0), "A")
        XCTAssertEqual(sut.usersTableView.userEmail(at: 0), "B")
        
        XCTAssertEqual(sut.usersTableView.userName(at: 1), "A1")
        XCTAssertEqual(sut.usersTableView.userEmail(at: 1), "B1")
    }
    
    
    //MARK:- Helper functions
    
    func makeSut() -> UsersListViewController {
        let vc = UIStoryboard.usersListViewController()
        weakSut = vc
        return vc
    }
    
    func makeSut(_ users: [UserModel]) -> UsersListViewController {
        let vc = makeSut()
        vc.injectDependency(networkManager: networkManager)
        vc.getUsers()
        networkManager.getUsersCallback?(users, true)
        
        _ = vc.view
        return vc
    }
    
    class MockUsersApi: UsersApiProtocol {
        var getUsersCallback: UsersApiProtocol.GetUsersCompletion?
        
        func getUsers(completion: @escaping UsersApiProtocol.GetUsersCompletion) {
            self.getUsersCallback = completion
        }
    }
    
    func makeUser(name: String = "N", email: String = "E") -> UserModel {
        return UserModel(name: name, email: email)
    }
}

private extension UITableView {
    func cell(at row: Int, for section: Int = 0) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: section))
    }
    
    func userName(at row: Int) -> String? {
        return (cell(at: row) as? UsersTableViewCell)?.lblUserName.text
    }
    
    func userEmail(at row: Int) -> String? {
        return (cell(at: row) as? UsersTableViewCell)?.lblUserEmail.text
    }
}
