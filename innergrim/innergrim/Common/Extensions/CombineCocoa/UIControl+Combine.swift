//
//  UIControl+Combine.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Combine
import UIKit

extension UIControl {
    func controlPublisher(for events: UIControl.Event) -> AnyPublisher<UIControl, Never> {
        ControlEvent(control: self, events: events)
            .eraseToAnyPublisher()
    }
}
