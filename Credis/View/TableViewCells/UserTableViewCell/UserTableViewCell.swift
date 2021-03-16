//
//  UserTableViewCell.swift
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

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var uuidLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = Constants.cellBackgroundColor
        layer.masksToBounds = Constants.masksToBound
        contentView.backgroundColor = Constants.contentViewColor
        contentView.layer.cornerRadius = Constants.cornerRadius
    }
}
