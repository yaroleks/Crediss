//
//  ViewController.swift
//  Credis
//
//  Created by Yaro on 3/13/21.
//

import UIKit

fileprivate struct Constants {
    static let backgroundColor = Color.backgroundColor
    static let deleteButtonTitle = "Delete"
    static let cellHeight: CGFloat = 80
    static let tableViewCornerRadius: CGFloat = 15
    static let tableViewSeparatorColor = Color.backgroundColor
}

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
        registerCell()
        setupUI()
    }

    // MARK: - IBActions
    @IBAction func addPressed(_ sender: Any) {
        storageService.addUser(User(uuid: UUID().uuidString))
        tableView.reloadData()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = Constants.backgroundColor
        tableView.layer.cornerRadius = Constants.tableViewCornerRadius
        tableView.separatorColor = Constants.tableViewSeparatorColor
    }
    
    private func registerCell() {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
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
        // NOTE: If it was a production app - we should have used a Coordinator class
        // to handle moving between screens
        let storyboard = UIStoryboard(name: Storyboards.Credentials.rawValue, bundle: nil)
        let identifier = String(describing: CredentialsListViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? CredentialsListViewController else {
            return
        }
        controller.user = users[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(
            style: .destructive,
            title: Constants.deleteButtonTitle
        ) { [weak self] (_, _, _) in
            guard let self = self else { return }
            self.storageService.removeUserAndCredentials(for: self.users[indexPath.row])
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
}

