//
//  CredentialsListViewController.swift
//  Credis
//
//  Created by Yaro on 3/13/21.
//

import Foundation

import UIKit
import NotificationBannerSwift

fileprivate struct Constants {
    static let tableViewCornerRadius: CGFloat = 15
    
    struct Banner {
        static let bannerTitle = "New credentials were added"
        static let backgroundColor = Color.mainThemeColor
        static let titleColor = Color.backgroundColor
        static let subtitleColor = Color.backgroundColor
        static let duration = 1.5
    }
    
    static let cellHeight: CGFloat = 55
}

final class CredentialsListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private var storageService: StorageService = StorageManager.shared
    private var networkService: NetworkService = NetworkManager.shared
    private var credentials: [Credential] {
        if let userId = user?.id {
            return storageService.credentials(for: userId).sorted{ $0.id < $1.id }
        } else {
            return [Credential]()
        }
    }
    var user: User?
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateDatasource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        tableView.register(
            UINib(nibName: String(describing: CredentialTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: CredentialTableViewCell.self)
        )
        tableView.layer.cornerRadius = Constants.tableViewCornerRadius
        tableView.separatorColor = Color.backgroundColor
        view.backgroundColor = Color.backgroundColor
    }
    
    private func showBanner(_ title: String, _ subtitle: String) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: .success)
        banner.backgroundColor = Constants.Banner.backgroundColor
        banner.titleLabel?.textColor = Constants.Banner.titleColor
        banner.subtitleLabel?.textColor = Constants.Banner.subtitleColor
        banner.duration = Constants.Banner.duration
        banner.show(bannerPosition: .bottom)
    }
    
    private func updateDatasource() {
        // TODO: Implement Datasource class that would get credentials
        if let userId = user?.id {
            networkService.credentials(userId: userId, after: credentials.last?.id ?? 0) { [weak self] (credentials, error) in
                guard let self = self else { return }
                if let error = error {
                    print("In the production - error should be handled: \(error)")
                } else if let credentials = credentials {
                    DispatchQueue.main.async {
                        self.storageService.addCredentials(credentials, for: userId)
                        if credentials.count > 0,
                           let credentialTitle = credentials.first?.title {
                            self.showBanner(Constants.Banner.bannerTitle, credentialTitle)
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CredentialsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credentials.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CredentialTableViewCell.self)) as? CredentialTableViewCell {
            cell.credentialLabel.text = credentials[indexPath.row].title
            cell.newLabel.isHidden = credentials[indexPath.row].alreadySeen
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: SingleCredentialViewController.self)) as? SingleCredentialViewController else {
            return
        }
        controller.credential = credentials[indexPath.row]
        storageService.updateCredentialSeenValue(credentials[indexPath.row], true)
        navigationController?.pushViewController(controller, animated: true)
    }
}
