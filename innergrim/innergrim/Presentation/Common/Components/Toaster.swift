//
//  Toaster.swift
//  innergrim
//
//  Created by 지연 on 12/23/24.
//

import UIKit

final class Toaster {
    // MARK: - Components
    
    private lazy var window: UIWindow? = {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            print("Toaster Error: window 생성 실패")
            return nil
        }
        let window = UIWindow(windowScene: windowScene)
        window.windowLevel = .alert
        window.isUserInteractionEnabled = false
        window.backgroundColor = .clear
        window.addSubview(backView)
        window.isHidden = true
        return window
    }()
    
    private let backView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.layoutMargins = .init(top: 12, left: 16, bottom: 12, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .gray800
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let warningImageView = {
        let imageView = UIImageView()
        imageView.image = .circleWarning
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let messageLabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    private static let instance = Toaster()
    
    private init() {
        setupLayout()
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        guard let window = window else { return }
        
        window.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.height.equalTo(46)
            make.center.equalToSuperview()
        }
        
        [warningImageView, messageLabel].forEach { backView.addArrangedSubview($0) }
        
        warningImageView.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
    }
    
    // MARK: - Make Toast ! 🍞
    
    static func makeToast(_ message: String) {
        guard let window = instance.window else { return }
        
        instance.messageLabel.text = message
        instance.messageLabel.applyTypography(with: .labelLargeMedium)
        
        window.isHidden = false
        window.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            window.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 1.5, options: .curveEaseIn, animations: {
                window.alpha = 0.0
            }) { _ in
                window.isHidden = true
            }
        }
    }
}
