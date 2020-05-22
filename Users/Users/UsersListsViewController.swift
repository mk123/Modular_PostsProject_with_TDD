//
//  UsersListsViewController.swift
//  Users
//
//  Created by Manjeet Kumar on 21/05/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation
import UIKit

public class UsersListViewController: UIViewController {
    @IBOutlet weak var usersTableView: UITableView!
    
    var networkManager: UsersApiProtocol!
    var usersList: [UserModel] = []
    
    func injectDependency(networkManager: UsersApiProtocol) {
        self.networkManager = networkManager
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.dataSource = self
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUsers()
    }
    
    func getUsers() {
        networkManager.getUsers(completion: {
            [weak self] (users, success) in
            guard let self = self else {return}
            if success {
                self.usersList = users
            } else {
                self.showError(message: "Error fetching users")
            }
        })
    }
    
    func showError(message: String?) {
        print("Error: ", message)
    }
}

extension UsersListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.identifier) as? UsersTableViewCell else {
            return UITableViewCell()
        }
        cell.cellConfig(userData: usersList[indexPath.row])
        return cell
    }
}


class UsersTableViewCell: UITableViewCell {
    static let identifier = "UsersTableViewCell"
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    
    func cellConfig(userData: UserModel) {
        lblUserName.text = userData.name
        lblUserEmail.text = userData.email
    }
}
