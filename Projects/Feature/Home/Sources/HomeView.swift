//
//  HomeView.swift
//  FeatureHome
//
//  Created by 지연 on 10/10/24.
//

import UIKit

import Shared

public final class HomeView: UIView {
    // MARK: - UI Components
    
    private let label = {
        let label = UILabel()
        label.text = "홈"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initialize
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
