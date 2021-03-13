//
//  ViewController.swift
//  Credis
//
//  Created by Yaro on 3/13/21.
//

import UIKit

final class UsersListViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var uuid = [String]()
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: IBActions
    @IBAction func addPressed(_ sender: Any) {
        uuid.append(UUID().uuidString)
        tableView.reloadData()
    }
    
    // MARK: Private methods
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
        return uuid.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserTableViewCell.self)) as? UserTableViewCell {
            cell.uuidLabel.text = uuid[indexPath.row]
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
        navigationController?.pushViewController(controller, animated: true)
    }
}

