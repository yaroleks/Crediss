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
    static let cellHeight: CGFloat = 55
    static let bannerTitle = "New credentials were added"
}

final class CredentialsListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    // In a production app - it should be injected from Coordinator
    private let credentialListModel: CredentialListModelProtocol = CredentialListModel()
    private var credentials: [Credential] {
        return credentialListModel.credentials(for: user?.id)
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
    
    private func updateDatasource() {
        credentialListModel.updateCredentialsDataSource(user?.id) { [weak self] (credentials, error) in
            guard let self = self else { return }
            if let error = error {
                self.showBanner(error.localizedDescription, type: .error)
            } else {
                DispatchQueue.main.async {
                    if credentials.count > 0,
                       let credentialTitle = credentials.first?.title {
                        self.showBanner(Constants.bannerTitle, credentialTitle, type: .success)
                    }
                    self.tableView.reloadData()
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
        // In a production app we should have used a Coordinator pattern
        // to separate logic for moving between screens
        let storyboard = UIStoryboard(name: Storyboards.SingleCredential.rawValue, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: SingleCredentialViewController.self)) as? SingleCredentialViewController else {
            return
        }
        controller.credential = credentials[indexPath.row]
        credentialListModel.updateCredentialSeenValue(credentials[indexPath.row], true) { error  in
            self.showBanner(error.localizedDescription, type: .error)
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}
