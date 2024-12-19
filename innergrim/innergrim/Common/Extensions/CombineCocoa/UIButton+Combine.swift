//
//  UIButton+Combine.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Combine
import UIKit

extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        controlPublisher(for: .touchUpInside)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
