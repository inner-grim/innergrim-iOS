//
//  ChatView.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

import SnapKit

final class ChatView: UIView {
    private var bottomConstraint: Constraint?
    
    // MARK: - Components
    
    let tableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.register(cellType: IncomingMessageCell.self)
        tableView.register(cellType: OutgoingMessageCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderTopPadding = 0
        tableView.sectionFooterHeight = 0
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let messageTextField = MessageTextField()
    
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
        addSubview(messageTextField)
        messageTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            bottomConstraint = make.bottom.equalToSuperview().constraint
            make.height.equalTo(112)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(messageTextField.snp.top)
        }
    }
    
    func updateBottomConstraint(keyboardHeight: CGFloat) {
        bottomConstraint?.update(offset: 36 - keyboardHeight)
        layoutIfNeeded()
    }
    
    func resetBottomConstraint() {
        bottomConstraint?.update(offset: 0)
        layoutIfNeeded()
    }
}
