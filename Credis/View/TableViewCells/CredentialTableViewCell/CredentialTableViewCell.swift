//
//  CredentialTableViewCell.swift
//  Credis
//
//  Created by Yaro on 3/13/21.
//

import UIKit

fileprivate struct Constants {
    static let cellBackgroundColor = Color.backgroundColor
    static let masksToBound = true
    static let contentViewColor = Color.mainThemeColor
    static let cornerRadius: CGFloat = 15
}

class CredentialTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var credentialLabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = Constants.cellBackgroundColor
        layer.masksToBounds = Constants.masksToBound
        contentView.backgroundColor = Constants.contentViewColor
        contentView.layer.cornerRadius = Constants.cornerRadius
    }
}
