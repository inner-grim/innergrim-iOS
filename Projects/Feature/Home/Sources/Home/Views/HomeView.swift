//
//  HomeView.swift
//  Home
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Shared

public final class HomeView: UIView {
    // MARK: - Components
    
    let shareTodayButton = SolidButton(title: "오늘 하루 털어놓기", font: .labelLargeSemiBold)
    
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
        addSubview(shareTodayButton)
        shareTodayButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
}
