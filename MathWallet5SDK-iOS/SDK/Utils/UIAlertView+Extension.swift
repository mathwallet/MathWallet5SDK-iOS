//
//  UIAlertView+Extension.swift
//  MathWallet5SDK-iOS
//
//  Created by math on 2021/10/20.
//

import UIKit

extension UIAlertController {
    static func show(_ viewController: UIViewController, title: String?, message: String?, action actionTitle: String = "dismiss", handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            handler?()
        }))
        viewController.present(alertController, animated: true, completion: nil)
    }
}
