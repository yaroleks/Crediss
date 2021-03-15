//
//  StorageManager.swift
//  Credis
//
//  Created by Yaro on 3/14/21.
//

import Foundation
import RealmSwift

final class StorageManager: StorageService {
    
    // MARK: - Initialization
    static let shared = StorageManager()
    private init() { }
    
    // MARK: - Properties
    let realm: Realm = {
        do {
            return try Realm()
        } catch {
            fatalError("Database couldn't be instantiated: \(error)")
        }
    }()
    
    // MARK: - Users
    func users() -> [User] {
        return realm.objects(User.self).map{ $0 }
    }
    
    func addUser(_ user: User) {
        do {
            try realm.write {
                realm.add(user)
            }
        } catch {
            print("Write operation cannot be finished - Handle in production app")
        }
    }
    
    // MARK: - Credentials
    
    func credentials(for userId: String) -> [Credential] {
        let keyPath = #keyPath(Credential.userId)
       
        return realm.objects(Credential.self).filter(
            NSPredicate(format: "%K == '\(userId)'", "\(keyPath)")
        ).map{ $0 }
    }
    
    func addCredentials(_ credentials: [Credential], for userId: String) {
        credentials.forEach {
            $0.userId = userId
        }
        
        do {
            try realm.write {
                realm.add(credentials)
            }
        } catch {
            print("Write operation cannot be finished - Handle in production app")
        }
    }
}
