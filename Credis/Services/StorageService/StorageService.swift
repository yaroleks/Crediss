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
    func addUser(_ user: User)
    func removeUserAndCredentials(for user: User)
    
    // MARK: - Credentials
    func credentials(for userId: String) -> [Credential]
    func addCredentials(_ credentials: [Credential],  for userId: String)
    func updateCredentialSeenValue(_ credential: Credential, _ seen: Bool)
}
