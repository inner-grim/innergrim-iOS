//
//  StatView.swift
//  FeatureMain
//
//  Created by 지연 on 10/10/24.
//

import UIKit
import SnapKit

import Shared

public final class StatView: UIView {
    // MARK: - UI Components
    
    private let label = {
        let label = UILabel()
        label.text = "전시"
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
