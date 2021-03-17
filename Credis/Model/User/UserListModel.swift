//
//  UserListModel.swift
//  Credis
//
//  Created by Yaro on 3/16/21.
//

import Foundation

protocol UserListModelProtocol {
    func users() -> [User]
    func addUser(_ errorHandler: (Error) -> ())
    func removeUser(_ userId: String, _ errorHandler: (Error) -> ())
}

final class UserListModel: UserListModelProtocol {
    
    // MARK: - Properties
    private let storageService: StorageService = StorageManager.shared
    var usersList = [User]()
    
    // MARK: - Public methods
    func users() -> [User] {
        if usersList.isEmpty {
            updateUserList()
        }
        return usersList
    }
    
    func addUser(_ errorHandler: (Error) -> ()) {
        let user = User(uuid: UUID().uuidString)
        storageService.addUser(user, errorHandler)
        updateUserList()
    }
    
    func removeUser(_ userId: String, _ errorHandler: (Error) -> ()) {
        guard let user = usersList.first(where: { $0.id == userId }) else { return }
        self.storageService.removeUserAndCredentials(for: user, errorHandler)
        updateUserList()
    }
    
    // MARK: - private func
    func updateUserList() {
        usersList = storageService.users()
    }
}
