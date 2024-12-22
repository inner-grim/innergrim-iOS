//
//  HomeView.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class HomeView: UIView {
    // MARK: - Components
    
    let calendarView = CalendarView()
    
    let shareTodayButton = SolidButton(title: "오늘 하루 털어놓기", font: .labelLargeSemiBold)
    
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
        addSubview(shareTodayButton)
        shareTodayButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(shareTodayButton.snp.top)
        }
    }
}
