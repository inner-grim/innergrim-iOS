//
//  ChatHeaderView.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class ChatHeaderView: UIView {
    // MARK: - Components
    
    private let label = {
        let label = UILabel()
        label.text = "무엇이든 함께 들어줄게. 시작해볼까?"
        label.applyTypography(with: .labelSmallMedium)
        label.textColor = .labelAssistive
        return label
    }()
    
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
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
