//
//  NetworkManager.swift
//  Credis
//
//  Created by Yaro on 3/14/21.
//

import Foundation
import GRPC

fileprivate struct NetworkManagerConstants {
    
    struct Configuration {
        static let loopCount = 1
        static let host = "localhost"
        static let port = 50051
    }
    
    struct Credentials {
        static let credentialsLimit: Int32 = 2
    }
}

final class NetworkManager: NetworkService {
    
    // MARK: - Initialization
    static let shared = NetworkManager()
    private init() { }
    
    // MARK: - ServiceClient
    private let serviceClient: Io_Iohk_Test_Protos_CredentialsServiceClient = {
        let group = PlatformSupport.makeEventLoopGroup(
            loopCount: NetworkManagerConstants.Configuration.loopCount)
        let channel = ClientConnection
            .insecure(group: group)
            .connect(host: NetworkManagerConstants.Configuration.host,
                     port: NetworkManagerConstants.Configuration.port)
        return Io_Iohk_Test_Protos_CredentialsServiceClient(channel: channel)
    }()
    
    // MARK: - Properties
    private let requestBuilder: RequestBuilder = RequestBuilder()
    
    // MARK: - Public Methods
    func credentials(userId: String, after: Int32 = 0, completion: @escaping credentialsCompletion) {
        let request = requestBuilder.credentialRequest(
            userId: userId,
            limit: NetworkManagerConstants.Credentials.credentialsLimit,
            after: after
        )
        
        serviceClient.getCredentials(request).response.whenComplete({ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let parsedCredentials = self.parse(response)
                if parsedCredentials.count == request.limit,
                   let lastId = parsedCredentials.last?.id {
                    self.credentials(userId: userId, after: lastId, completion: completion)
                } else {
                    completion(self.parse(response), nil)
                }
            case .failure(let error):
                completion(nil, error)
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
