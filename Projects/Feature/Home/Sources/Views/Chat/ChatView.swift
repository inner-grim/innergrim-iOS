//
//  ChatView.swift
//  FeatureHome
//
//  Created by 지연 on 11/6/24.
//

import UIKit

import Shared

public final class ChatView: UIView {
    // MARK: - Components
    
    let messageTextField = MessageTextField()
    
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
        addSubview(messageTextField)
        messageTextField.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(112)
        }
    }
}
