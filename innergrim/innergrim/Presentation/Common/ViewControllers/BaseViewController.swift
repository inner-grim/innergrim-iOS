//
//  BaseViewController.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

import SnapKit

class BaseViewController<View: UIView>: UIViewController {
    private var contentBottomConstraint: Constraint?
    
    // MARK: - Components
    
    private let navigationBar = UIView()
    
    let contentView = View()
    
    private lazy var titleLabel = createTitleLabel()
    
    lazy var backButton = createButton()
    
    lazy var actionButton = createButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
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
            make.leading.trailing.equalToSuperview()
            contentBottomConstraint = make.bottom.equalToSuperview().constraint
        }
    }
    
    // MARK: - Configure Methods
    
    func configureNavigationBar(
        title: String? = nil,
        backImage: UIImage? = nil,
        actionImage: UIImage? = nil
    ) {
        if let title = title {
            titleLabel.text = title
            navigationBar.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
        
        if let backImage = backImage {
            backButton.setImage(backImage, for: .normal)
            navigationBar.addSubview(backButton)
            backButton.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(16)
                make.centerY.equalToSuperview()
            }
        }
        
        if let actionImage = actionImage {
            actionButton.setImage(actionImage, for: .normal)
            navigationBar.addSubview(actionButton)
            actionButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(24)
                make.centerY.equalToSuperview()
            }
        }
    }
    
    func setNavigationBarHidden() {
        navigationBar.removeFromSuperview()
        
        contentView.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            contentBottomConstraint = make.bottom.equalToSuperview().constraint
        }
    }
    
    func configureBottomSafeArea() {
        contentBottomConstraint?.update(offset: -view.safeAreaInsets.bottom)
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
