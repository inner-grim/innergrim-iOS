//
//  ChatEndCell.swift
//  innergrim
//
//  Created by 지연 on 1/5/25.
//

import UIKit

final class ChatEndCell: UITableViewCell, Reusable {
    // MARK: - Components
    
    private let messageContainer = {
        let view = UIView()
        view.backgroundColor = .primaryLight
        view.layer.masksToBounds = true
        return view
    }()
    
    private let messageLabel = {
        let label = UILabel()
        label.textColor = .labelNormal
        label.numberOfLines = 0
        return label
    }()
    
    let endButton = SolidButton(title: "대화 종료하기", font: .labelMediumSemiBold)
    
    let continueButton = {
        let button = AssistiveButton(title: "이어서 하기", font: .labelMediumSemiBold)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.primaryNormal.cgColor
        return button
    }()
    
    private let timestampLabel = {
        let label = UILabel()
        label.textColor = .labelAssistive
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupLayout()
        setupMessageContainerCorners()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async { [weak self] in
            self?.setupMessageContainerCorners()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageContainer.layer.mask = nil
    }
    
    // MARK: - Setup Methods
    
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupLayout() {
        contentView.addSubview(messageContainer)
        messageContainer.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview()
            make.width.equalTo(236)
        }
        
        messageContainer.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        messageContainer.addSubview(endButton)
        endButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(12)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        messageContainer.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(endButton.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(timestampLabel)
        timestampLabel.snp.makeConstraints { make in
            make.leading.equalTo(messageContainer.snp.trailing).offset(2)
            make.bottom.equalToSuperview().inset(10)
            make.trailing.lessThanOrEqualToSuperview().inset(24)
        }
    }
    
    private func setupMessageContainerCorners() {
        // bounds 체크
        guard messageContainer.bounds.width > 0, messageContainer.bounds.height > 0 else { return }
        
        // 이미 mask가 설정되어 있고 크기가 같다면 스킵
        if let currentMask = messageContainer.layer.mask as? CAShapeLayer,
           currentMask.bounds == messageContainer.bounds {
            return
        }
        
        let path = UIBezierPath()
        let containerRect = messageContainer.bounds
        
        // 좌측 상단 코너 (radius: 4)
        path.move(to: CGPoint(x: 0, y: 4))
        path.addArc(withCenter: CGPoint(x: 4, y: 4),
                    radius: 4,
                    startAngle: .pi,
                    endAngle: .pi * 3/2,
                    clockwise: true)
        
        // 우측 상단 코너 (radius: 20)
        path.addLine(to: CGPoint(x: containerRect.width - 20, y: 0))
        path.addArc(withCenter: CGPoint(x: containerRect.width - 20, y: 20),
                    radius: 20,
                    startAngle: .pi * 3/2,
                    endAngle: 0,
                    clockwise: true)
        
        // 우측 하단 코너 (radius: 20)
        path.addLine(to: CGPoint(x: containerRect.width, y: containerRect.height - 20))
        path.addArc(withCenter: CGPoint(x: containerRect.width - 20, y: containerRect.height - 20),
                    radius: 20,
                    startAngle: 0,
                    endAngle: .pi/2,
                    clockwise: true)
        
        // 좌측 하단 코너 (radius: 20)
        path.addLine(to: CGPoint(x: 20, y: containerRect.height))
        path.addArc(withCenter: CGPoint(x: 20, y: containerRect.height - 20),
                    radius: 20,
                    startAngle: .pi/2,
                    endAngle: .pi,
                    clockwise: true)
        
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.frame = containerRect
        messageContainer.layer.mask = shapeLayer
    }
    
    // MARK: - Configure Methods
    
    func configure(with message: ChatMessage) {
        messageLabel.text = message.content
        messageLabel.applyTypography(with: .labelMediumMedium)
        timestampLabel.text = message.timestamp.formatAsTime()
        timestampLabel.applyTypography(with: .labelXSmallMedium)
    }
}
