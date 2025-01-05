//
//  HomeView.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class HomeView: UIView {
    // MARK: - Components
    
    let settingsButton = {
        let button = UIButton()
        button.setImage(.settings, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let calendarView = CalendarView()
    
    let shareTodayButton = SolidButton(
        title: "오늘 하루 털어놓기",
        disabledTitle: "내일 또 만나자!",
        font: .labelLargeSemiBold
    )
    
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
        addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(24)
        }
        
        addSubview(shareTodayButton)
        shareTodayButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(settingsButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(shareTodayButton.snp.top)
        }
    }
}
