//
//  SolidButton.swift
//  SharedDesignSystem
//
//  Created by 지연 on 11/23/24.
//

import UIKit

public final class SolidButton: UIButton {
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
        // 배경 색상
        setBackgroundImage(image(with: .primaryNormal), for: .normal)
        setBackgroundImage(image(with: .primaryStrong), for: .highlighted)
        setBackgroundImage(image(with: .fillDisabled), for: .disabled)
        // 타이틀 색상
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .highlighted)
        setTitleColor(.labelDisabled, for: .disabled)
        // 레이어
        clipsToBounds = true
        layer.cornerRadius = 8.0
    }
}
