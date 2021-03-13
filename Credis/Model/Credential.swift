//
//  Credential.swift
//  Credis
//
//  Created by Yaro on 3/13/21.
//

import Foundation

//    int32 id = 1; // the unique incremental id for the credential (starts at 1)
//    int64 issuedOn = 2; // a System.currentTimeMillis() when the credential was issued
//    string subject = 3; // the subject's name for this credential
//    string issuer = 4; // the issuer's name emitting this credential
//    string title = 5; // the title on the credential

struct Credential {
    let id: Int32
    let issuedOn: Int64
    let subject: String
    let issuer: String
    let title: String
}
