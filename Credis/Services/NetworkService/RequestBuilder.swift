//
//  RequestBuilder.swift
//  Credis
//
//  Created by Yaro on 3/14/21.
//

import Foundation

final class RequestBuilder {
    
    func credentialRequest(
        userId: String,
        limit: Int32,
        after: Int32
    ) -> Io_Iohk_Test_Protos_GetCredentialsRequest {
        var request = Io_Iohk_Test_Protos_GetCredentialsRequest()
        request.userID = userId
        request.after = after
        request.limit = limit
        return request
    }
}
