//
//  User.swift
//  Credis
//
//  Created by Yaro on 3/14/21.
//

import Foundation
import RealmSwift

class User: Object {

    @objc dynamic var id: String = ""
    
    convenience init(uuid: String) {
        self.init()
        self.id = uuid
    }
}
