//
//  StorageService.swift
//  Credis
//
//  Created by Yaro on 3/14/21.
//

import Foundation

protocol StorageService {
    
    func users() -> [User]
    func addUser(_ user: User)
    
    func credentials(for userId: String) -> [Credential]
    func addCredentials(_ credentials: [Credential],  for userId: String)
}
