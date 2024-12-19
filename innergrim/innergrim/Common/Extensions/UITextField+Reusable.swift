//
//  UITextField+Reusable.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Combine
import UIKit

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        Publishers.Merge(
            publisher(for: \.text).compactMap { $0 },
            NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)
                .compactMap { ($0.object as? UITextField)?.text }
        )
        .removeDuplicates()
        .eraseToAnyPublisher()
    }
}
