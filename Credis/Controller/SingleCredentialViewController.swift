//
//  SingleCredentialViewController.swift
//  Credis
//
//  Created by Yaro on 3/13/21.
//

import UIKit

final class SingleCredentialViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet var singleCredentialsView: SingleCredentialView!
    
    // MARK: Properties
    var credential: Credential? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureUI()
    }
    
    // MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Private functions
    func configureUI() {
        if let credential = credential {
            singleCredentialsView.titleLabel.text = credential.title
            singleCredentialsView.nameLabel.text = credential.subject
            singleCredentialsView.issuedOnLabel.text = String(credential.issuedOn)
            singleCredentialsView.idLabel.text = String(credential.id)
            singleCredentialsView.issuerLabel.text = credential.issuer
            singleCredentialsView.isHidden = false
        }
    }

}
