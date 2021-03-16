//
//  CredentialListModel.swift
//  Credis
//
//  Created by Yaro on 3/16/21.
//

import Foundation

typealias UptadeDatasourceCompletion = (([Credential], Error?) -> Void)

protocol CredentialListModelProtocol {
    func credentials(for userId: String?) -> [Credential]
    func updateCredentialsDataSource(
        _ userId: String?,
        _ completion: @escaping UptadeDatasourceCompletion
    )
    func updateCredentialSeenValue(_ credential: Credential, _ seen: Bool)
}

final class CredentialListModel: CredentialListModelProtocol {
    
    // MARK: - Properties
    private let storageService: StorageService = StorageManager.shared
    private let networkService: NetworkService = NetworkManager.shared
    private var credentialsList = [Credential]()
    
    // MARK: - Public methods
    func credentials(for userId: String?) -> [Credential] {
        if let userId = userId,
           credentialsList.isEmpty {
            updateCredentials(for: userId)
        }
        return credentialsList
    }
    
    func updateCredentialsDataSource(_ userId: String?, _ completion: @escaping UptadeDatasourceCompletion) {
        if let userId = userId {
            networkService.credentials(userId: userId, after: credentials(for: userId).last?.id ?? 0) { [weak self] (credentials, error) in
                guard let self = self else { return }
                if let error = error {
                    completion([], error)
                    print("In the production - error should be handled: \(error)")
                } else if let credentials = credentials {
                    DispatchQueue.main.async {
                        self.storageService.addCredentials(credentials, for: userId)
                        self.updateCredentials(for: userId)
                    }
                    completion(credentials, nil)
                }
            }
        }
    }
    
    func updateCredentialSeenValue(_ credential: Credential, _ seen: Bool) {
        storageService.updateCredentialSeenValue(credential, seen)
    }
    
    // MARK: - Private methods
    private func updateCredentials(for userId: String) {
        credentialsList = storageService.credentials(for: userId).sorted{ $0.id < $1.id }
    }
}
