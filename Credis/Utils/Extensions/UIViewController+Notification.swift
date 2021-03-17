//
//  UIViewController + Notification.swift
//  Credis
//
//  Created by Yaro on 3/17/21.
//

import Foundation
import UIKit
import NotificationBannerSwift

fileprivate struct BannerConstants {
    struct Success {
        static let backgroundColor = Color.mainThemeColor
        static let titleColor = Color.backgroundColor
        static let subtitleColor = Color.backgroundColor
    }
    
    struct Error {
        static let backgroundColor = UIColor.red
        static let titleColor = UIColor.white
        static let subtitleColor = UIColor.white
    }
    
    static let duration = 1.5
}

enum BannerType {
    case success, error
}

extension UIViewController {
    
    func showBanner(_ title: String, _ subtitle: String? = nil, type: BannerType) {
        
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: .success)
        switch type {
        case .success:
            banner.backgroundColor = BannerConstants.Success.backgroundColor
            banner.titleLabel?.textColor = BannerConstants.Success.titleColor
            banner.subtitleLabel?.textColor = BannerConstants.Success.subtitleColor
            
        case .error:
            banner.backgroundColor = BannerConstants.Error.backgroundColor
            banner.titleLabel?.textColor = BannerConstants.Error.titleColor
            banner.subtitleLabel?.textColor = BannerConstants.Error.subtitleColor
        }
        banner.duration = BannerConstants.duration
        banner.show(bannerPosition: .bottom)
    }
}
