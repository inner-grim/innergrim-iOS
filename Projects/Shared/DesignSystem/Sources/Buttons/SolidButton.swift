//
//  SolidButton.swift
//  SharedDesignSystem
//
//  Created by 지연 on 11/5/24.
//

import UIKit

public final class SolidButton: UIButton {
    private let defaultBackgroundColor = SharedDesignSystemAsset.Colors.primaryNormal.color
    private let pressedBackgroundColor = SharedDesignSystemAsset.Colors.primaryStrong.color
    private let disabledBackgroundColor = SharedDesignSystemAsset.Colors.fillDisabled.color
    private let defaultTextColor = UIColor.white
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
        let attributedString = NSAttributedString(string: title, attributes: [.font: font])
        setAttributedTitle(attributedString, for: .normal)
        setTitleColor(defaultTextColor, for: .normal)
        setTitleColor(disabledTextColor, for: .disabled)
        
        setBackgroundImage(imageWithColor(color: defaultBackgroundColor), for: .normal)
        setBackgroundImage(imageWithColor(color: pressedBackgroundColor), for: .highlighted)
        setBackgroundImage(imageWithColor(color: disabledBackgroundColor), for: .disabled)
        
        clipsToBounds = true
        layer.cornerRadius = 8
    }
}
