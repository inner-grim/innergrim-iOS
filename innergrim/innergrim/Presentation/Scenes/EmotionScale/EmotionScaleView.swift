//
//  EmotionScaleView.swift
//  innergrim
//
//  Created by 지연 on 1/4/25.
//

import UIKit

final class EmotionScaleView: UIView {
    // MARK: - Components
    
    let doneButton = SolidButton(title: "확인", font: .labelLargeSemiBold)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(48)
        }
    }
}
