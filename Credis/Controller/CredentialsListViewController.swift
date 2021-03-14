//
//  CredentialsListViewController.swift
//  Credis
//
//  Created by Yaro on 3/13/21.
//

import Foundation

import UIKit

final class CredentialsListViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var credentials = [
        Credential(id: 1, issuedOn: 1, subject: "subject", issuer: "issuer", title: "title1"),
        Credential(id: 1, issuedOn: 1, subject: "subject", issuer: "issuer", title: "title2"),
        Credential(id: 1, issuedOn: 1, subject: "subject", issuer: "issuer", title: "title3")
    ]
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        tableView.register(
            UINib(nibName: String(describing: CredentialTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: CredentialTableViewCell.self)
        )
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CredentialsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credentials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CredentialTableViewCell.self)) as? CredentialTableViewCell {
            cell.credentialLabel.text = credentials[indexPath.row].title
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
        navigationController?.pushViewController(controller, animated: true)
    }
}
