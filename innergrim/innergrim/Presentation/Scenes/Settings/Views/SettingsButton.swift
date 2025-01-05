//
//  SettingsButton.swift
//  innergrim
//
//  Created by 지연 on 1/4/25.
//

import UIKit

final class SettingsButton: UIButton {
    // MARK: - Components
    
    private let label = {
        let label = UILabel()
        label.textColor = .labelNormal
        return label
    }()
    
    private let chevronImageView = {
        let imageView = UIImageView()
        imageView.image = .chevronRight
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    
    init(title: String, isChevronHidden: Bool = false) {
        super.init(frame: .zero)
        setupButton(title: title, isChevronHidden: isChevronHidden)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupButton(title: String, isChevronHidden: Bool) {
        backgroundColor = .clear
        label.text = title
        label.applyTypography(with: .bodyLargeSemiBold)
        chevronImageView.isHidden = isChevronHidden
    }
    
    private func setupLayout() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
