//
//  UIResponder+Combine.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Combine
import UIKit

extension UIResponder {
    var keyboardWillShowPublisher: AnyPublisher<CGFloat, Never> {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
            .map { $0.cgRectValue.height }
            .eraseToAnyPublisher()
    }
    
    var keyboardWillHidePublisher: AnyPublisher<Notification, Never> {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .eraseToAnyPublisher()
    }
}
