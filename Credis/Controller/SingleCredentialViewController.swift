//
//  SingleCredentialViewController.swift
//  Credis
//
//  Created by Yaro on 3/13/21.
//

import UIKit

final class SingleCredentialViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var singleCredentialsView: SingleCredentialView!
    
    // MARK: - Properties
    var credential: Credential?
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private functions
    func configureUI() {
        if let credential = credential {
            singleCredentialsView.setupView(credential)
        }
    }

}
