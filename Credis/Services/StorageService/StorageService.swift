//
//  StorageService.swift
//  Credis
//
//  Created by Yaro on 3/14/21.
//

import Foundation

protocol StorageService {
    
    // MARK: - Users
    func users() -> [User]
    func addUser(_ user: User, _ errorHandler: (Error) -> ())
    func removeUserAndCredentials(for user: User, _ errorHandler: (Error) -> ())
    
    // MARK: - Credentials
    func credentials(for userId: String) -> [Credential]
    func addCredentials(_ credentials: [Credential],  _ userId: String, _ errorHandler: (Error) -> ())
    func updateCredentialSeenValue(_ credential: Credential, _ seen: Bool, _ errorHandler: (Error) -> ())
}
