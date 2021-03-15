//
//  Credential.swift
//  Credis
//
//  Created by Yaro on 3/13/21.
//

import Foundation
import RealmSwift

class Credential: Object {

    @objc dynamic var id: Int32 = 0
    @objc dynamic var issuedOn: Date = Date()
    @objc dynamic var subject: String = ""
    @objc dynamic var issuer: String = ""
    @objc dynamic var title: String = ""
    
    // Used for linking between a credential and a user
    @objc dynamic var userId: String = ""
    
    convenience init(id: Int32, issuedOn: Date, subject: String, issuer: String, title: String) {
        self.init()
        self.id = id
        self.issuedOn = issuedOn
        self.subject = subject
        self.issuer = issuer
        self.title = title
    }
}
