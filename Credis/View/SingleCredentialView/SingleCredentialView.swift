//
//  SingleCredentialView.swift
//  Credis
//
//  Created by Yaro on 3/13/21.
//

import UIKit

fileprivate struct SingleCredentialConstatns {
    static let cornerRadius: CGFloat = 10
}

final class SingleCredentialView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var bodyView: UIView!
    @IBOutlet weak var issuerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var issuedOnLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setShadows()
    }
    
    // MARK: Public methods
    func setupView(_ credential: Credential) {
        titleLabel.text = credential.title
        nameLabel.text = credential.subject
        issuedOnLabel.text = String(credential.issuedOn)
        idLabel.text = String(credential.id)
        issuerLabel.text = credential.issuer
        isHidden = false
    }

    // MARK: Private functions
    private func commonInit() {
        instantiateView()
        addSubview(contentView)
        configureUI()
    }
    
    private func instantiateView() {
        let nib = UINib(nibName: String(describing: SingleCredentialView.self), bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
    }
    
    private func configureUI() {
        contentView.frame = bounds
        contentView.layer.cornerRadius = SingleCredentialConstatns.cornerRadius
        addConstraints()
    }
    
    private func addConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: contentView.topAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func setShadows() {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: SingleCredentialConstatns.cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor

        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2, height: 2.0)
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.shadowRadius = 2

        layer.insertSublayer(shadowLayer, at: 0)
    }
}
