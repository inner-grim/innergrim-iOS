//
//  AssistiveButton.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import UIKit

final class AssistiveButton: UIButton {
    // MARK: - Init
    
    public init(initialEnabled: Bool = true, title: String, font: UIFont) {
        super.init(frame: .zero)
        isEnabled = initialEnabled
        setupButton(with: title, font: font)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupButton(with title: String, font: UIFont) {
        // 타이틀
        setupTitle(for: .normal, title, font, .primaryNormal)
        setupTitle(for: .highlighted, title, font, .primaryStrong)
        setupTitle(for: .disabled, title, font, .labelDisabled)
        // 배경 색상
        setBackgroundImage(image(with: .primaryLight), for: .normal)
        setBackgroundImage(image(with: .coral100), for: .highlighted)
        setBackgroundImage(image(with: .fillDisabled), for: .disabled)
        // 레이어
        clipsToBounds = true
        layer.cornerRadius = 8.0
    }
    
    private func setupTitle(
        for state: UIControl.State,
        _ title: String,
        _ font: UIFont,
        _ textColor: UIColor
    ) {
        let attributedString = NSAttributedString(
            string: title,
            attributes:
                [
                    .font: font,
                    .foregroundColor: textColor
                ]
        )
        setAttributedTitle(attributedString, for: state)
    }
}
