//
//  UILabel+.swift
//  SharedUtil
//
//  Created by 지연 on 11/5/24.
//

import UIKit

import SharedDesignSystem

extension UILabel {
    private func setLineHeightAsPercentage(_ percentage: CGFloat) {
        guard let text = self.text else { return }
        
        let fontSize = font.pointSize
        let lineHeight = fontSize * (percentage / 100.0)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        
        let baselineOffset = (lineHeight - fontSize) / 4
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .baselineOffset: baselineOffset
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedString
    }
    
    public func applyTypography(with font: UIFont) {
        self.font = font
        
        switch font {
        case .headingLarge:
            setLineHeightAsPercentage(144)
        case .headingMedium:
            setLineHeightAsPercentage(144)
        case .headingSmall:
            setLineHeightAsPercentage(142)
        case .titleLarge:
            setLineHeightAsPercentage(140)
        case .titleMedium:
            setLineHeightAsPercentage(132)
        case .titleSmall:
            setLineHeightAsPercentage(136)
        case .bodyLargeRegular:
            setLineHeightAsPercentage(158)
        case .bodyLargeSemiBold:
            setLineHeightAsPercentage(158)
        case .bodyMediumRegular:
            setLineHeightAsPercentage(154)
        case .bodyMediumSemiBold:
            setLineHeightAsPercentage(154)
        case .labelLargeMedium:
            setLineHeightAsPercentage(140)
        case .labelLargeSemiBold:
            setLineHeightAsPercentage(140)
        case .labelMediumMedium:
            setLineHeightAsPercentage(140)
        case .labelMediumSemiBold:
            setLineHeightAsPercentage(140)
        case .labelSmallMedium:
            setLineHeightAsPercentage(136)
        case .labelSmallSemiBold:
            setLineHeightAsPercentage(136)
        case .labelXSmallMedium:
            setLineHeightAsPercentage(134)
        case .labelXSmallSemiBold:
            setLineHeightAsPercentage(134)
        default: break
        }
    }
}
