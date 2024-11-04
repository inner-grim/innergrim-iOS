//
//  AssistiveButton.swift
//  SharedDesignSystem
//
//  Created by 지연 on 11/5/24.
//

import UIKit

public final class AssistiveButton: UIButton {
    private let defaultBackgroundColor = SharedDesignSystemAsset.Colors.primaryLight.color
    private let pressedBackgroundColor = SharedDesignSystemAsset.Colors.coral100.color
    private let disabledBackgroundColor = SharedDesignSystemAsset.Colors.fillDisabled.color
    private let defaultTextColor = SharedDesignSystemAsset.Colors.primaryNormal.color
    private let pressedTextColor = SharedDesignSystemAsset.Colors.primaryStrong.color
    private let disabledTextColor = SharedDesignSystemAsset.Colors.labelDisabled.color
    
    // MARK: - Init
    
    public init(title: String, font: UIFont) {
        super.init(frame: .zero)
        setupButton(with: title, font: font)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupButton(with title: String, font: UIFont) {
        // 기본 상태
        let normalAttributedString = NSAttributedString(
            string: title,
            attributes: [.font: font, .foregroundColor: defaultTextColor]
        )
        setAttributedTitle(normalAttributedString, for: .normal)
        
        // 하이라이트 상태
        let highlightedAttributedString = NSAttributedString(
            string: title,
            attributes: [.font: font, .foregroundColor: pressedTextColor]
        )
        setAttributedTitle(highlightedAttributedString, for: .highlighted)
        
        // 비활성화 상태
        let disabledAttributedString = NSAttributedString(
            string: title,
            attributes: [.font: font, .foregroundColor: disabledTextColor]
        )
        setAttributedTitle(disabledAttributedString, for: .disabled)
        
        setBackgroundImage(imageWithColor(color: defaultBackgroundColor), for: .normal)
        setBackgroundImage(imageWithColor(color: pressedBackgroundColor), for: .highlighted)
        setBackgroundImage(imageWithColor(color: disabledBackgroundColor), for: .disabled)
        
        clipsToBounds = true
        layer.cornerRadius = 8
    }
}
