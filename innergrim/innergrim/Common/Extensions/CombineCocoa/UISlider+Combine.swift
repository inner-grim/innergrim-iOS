//
//  UISlider+Combine.swift
//  innergrim
//
//  Created by 지연 on 1/4/25.
//

import Combine
import UIKit

public extension UISlider {
    var valuePublisher: AnyPublisher<Float, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.value)
                  .eraseToAnyPublisher()
    }
}
