//
//  HapticFeedbackable.swift
//  innergrim
//
//  Created by 지연 on 1/5/25.
//

import UIKit

protocol HapticFeedbackable {
    func generateHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle)
}

extension HapticFeedbackable {
    func generateHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
