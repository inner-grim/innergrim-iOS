//
//  UIViewController+.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import UIKit

extension UIViewController {
    func showAlert(
        title: String,
        message: String,
        leftActionText: String,
        rightActionText: String,
        leftActionCompletion: (() -> Void)? = nil,
        rightActionCompletion: (() -> Void)? = nil
    ) {
        let alertViewController = AlertViewController(
            title: title,
            message: message,
            leftActionText: leftActionText,
            rightActionText: rightActionText,
            leftActionCompletion: leftActionCompletion,
            rightActionCompletion: rightActionCompletion
        )
        present(alertViewController, animated: false)
    }
}
