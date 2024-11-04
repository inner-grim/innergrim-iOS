//
//  UIButton+.swift
//  SharedUtil
//
//  Created by 지연 on 11/5/24.
//

import Combine
import UIKit

extension UIButton {
    public var tapPublisher: AnyPublisher<Void, Never> {
        controlPublisher(for: .touchUpInside)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
