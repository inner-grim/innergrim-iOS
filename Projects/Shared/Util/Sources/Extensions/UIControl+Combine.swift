//
//  UIControl+Combine.swift
//  SharedUtil
//
//  Created by 지연 on 11/5/24.
//

import Combine
import UIKit

extension UIControl {
    func controlPublisher(for events: UIControl.Event) -> AnyPublisher<UIControl, Never> {
        ControlEvent(control: self, events: events)
            .eraseToAnyPublisher()
    }
}
