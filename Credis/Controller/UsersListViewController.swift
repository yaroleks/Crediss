//
//  ViewController.swift
//  Credis
//
//  Created by Yaro on 3/13/21.
//

import UIKit

final class UsersListViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    lazy private var storageService: StorageService = StorageManager.shared
    private var users: [User] {
        return storageService.users()
    }
    
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - IBActions
    @IBAction func addPressed(_ sender: Any) {
        storageService.addUser(User(uuid: UUID().uuidString))
        tableView.reloadData()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        tableView.register(
            UINib(nibName: String(describing: UserTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: UserTableViewCell.self)
        )
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserTableViewCell.self)) as? UserTableViewCell {
            cell.uuidLabel.text = users[indexPath.row].id
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: CredentialsListViewController.self)) as? CredentialsListViewController else {
            return
        }
        controller.user = users[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

