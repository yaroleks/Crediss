//
//  NetworkManager.swift
//  Credis
//
//  Created by Yaro on 3/14/21.
//

import Foundation
import GRPC

fileprivate struct NetworkManagerConstants {
    
    static let loopCount = 1
    static let host = "localhost"
    static let port = 50051
}

final class NetworkManager: NetworkService {
    
    // MARK: - Initialization
    static let shared = NetworkManager()
    
    private init(requestBuilder: RequestBuilder = RequestBuilder()) {
        self.requestBuilder = requestBuilder
    }
    
    // MARK: - ServiceClient
    private let serviceClient: Io_Iohk_Test_Protos_CredentialsServiceClient = {
        let group = PlatformSupport.makeEventLoopGroup(
            loopCount: NetworkManagerConstants.loopCount)
        let channel = ClientConnection
            .insecure(group: group)
            .connect(host: NetworkManagerConstants.host,
                     port: NetworkManagerConstants.port)
        return Io_Iohk_Test_Protos_CredentialsServiceClient(channel: channel)
    }()
    
    // MARK: - Properties
    private var requestBuilder: RequestBuilder
    
    // MARK: - Public Methods
    func credentials(
        userId: String,
        limit: Int32,
        after: Int32,
        completion: @escaping credentialsCompletion
    ) {
        let request = requestBuilder.credentialRequest(userId: userId, limit: limit, after: after)
        
        serviceClient.getCredentials(request).response.whenComplete({ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseData):
                completion(self.parse(responseData), nil)
            case .failure(let error):
                // Error should be handled in the real app with showing a pop-up, view, etc."
                print("Error: \(error)")
            }
        })
    }
    
    // MARK:  - Private methods
    private func parse(_ response: Io_Iohk_Test_Protos_GetCredentialsResponse) -> [Credential] {
        return response.credentials.compactMap { (protoCredential) -> Credential in
            return Credential(
                id: protoCredential.id,
                issuedOn: convertToDate(protoCredential.issuedOn),
                subject: protoCredential.subject,
                issuer: protoCredential.issuer,
                title: protoCredential.title)
        }
    }
    
    private func convertToDate(_ millisecond: Int64) -> Date {
        return Date(timeIntervalSince1970: Double(millisecond / 1000))
    }
}
