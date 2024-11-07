//
//  ChatHeaderView.swift
//  FeatureHome
//
//  Created by 지연 on 11/6/24.
//

import UIKit

import Shared

public final class ChatHeaderView: UIView {
    // MARK: - Components
    
    private let label = {
        let label = UILabel()
        label.text = "무엇이든 함께 들어줄게. 시작해볼까?"
        label.applyTypography(with: .labelSmallMedium)
        label.textColor = .labelAssistive
        label.transform = CGAffineTransform(scaleX: 1, y: -1)
        return label
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
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
