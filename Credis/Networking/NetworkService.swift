//
//  NetworkService.swift
//  Credis
//
//  Created by Yaro on 3/14/21.
//

import Foundation

protocol NetworkService {
    
    typealias credentialsCompletion = ([Credential]?, Error?) -> ()
    
    func credentials(userId: String, limit: Int32, after: Int32, completion: @escaping credentialsCompletion)
}
