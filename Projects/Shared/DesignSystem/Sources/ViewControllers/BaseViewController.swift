//
//  BaseViewController.swift
//  SharedDesignSystem
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import SnapKit

open class BaseViewController<View: UIView>: UIViewController {
    // MARK: - Components
    
    private let navigationBar = UIView()
    
    public let contentView = View()
    
    private lazy var titleLabel = createTitleLabel()
    
    public lazy var dismissButton = createButton(with: .dismiss)
    
    public lazy var actionButton = createButton()
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupLayout()
    }
    
    // MARK: - Setup Methods
    
    private func setupViewController() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Configure Methods
    
    public func configureNavigationBar(
        isDismissButtonHidden: Bool = false,
        title: String? = nil,
        isTitleCenter: Bool = true,
        actionImage: UIImage? = nil
    ) {
        if !isDismissButtonHidden {
            navigationBar.addSubview(dismissButton)
            dismissButton.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(16)
                make.centerY.equalToSuperview()
            }
        }
        
        if let title = title {
            titleLabel.text = title
            navigationBar.addSubview(titleLabel)
            if isTitleCenter {
                titleLabel.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                }
            } else {
                titleLabel.snp.makeConstraints { make in
                    make.leading.equalTo(dismissButton.snp.trailing).offset(20)
                    make.centerY.equalToSuperview()
                }
            }
        }
        
        if let image = actionImage {
            actionButton.setImage(image, for: .normal)
            navigationBar.addSubview(actionButton)
            actionButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(24)
                make.centerY.equalToSuperview()
            }
        }
    }
    
    public func setNavigationBarHidden() {
        navigationBar.removeFromSuperview()
        
        contentView.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Helper Methods
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .titleSmall
        label.textColor = .labelNormal
        return label
    }
    
    private func createButton(with image: UIImage? = nil) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        return button
    }
}
