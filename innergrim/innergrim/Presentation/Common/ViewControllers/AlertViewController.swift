//
//  AlertViewController.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import UIKit

final class AlertViewController: UIViewController {
    private var leftActionCompletion: (() -> Void)?
    private var rightActionCompletion: (() -> Void)?
    
    // MARK: - UI Components
    
    private let containerView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let buttonContainer = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = createLabel()
    private lazy var messageLabel: UILabel = createLabel()
    private var leftButton: AssistiveButton?
    private var rightButton: SolidButton?
    private lazy var singleButton = createButton()
    
    // MARK: - Init
    
    init(
        title: String,
        message: String,
        leftActionText: String,
        rightActionText: String,
        leftActionCompletion: (() -> Void)? = nil,
        rightActionCompletion: (() -> Void)? = nil
    ) {
        super.init(nibName: nil, bundle: nil)
        
        setupCommon()
        setupAlertView(
            title: title,
            message: message,
            leftActionText: leftActionText,
            rightActionText: rightActionText
        )
        setupActions(
            leftActionCompletion: leftActionCompletion,
            rightActionCompletion: rightActionCompletion
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        prepareForAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIn()
    }
    
    // MARK: - Setup Methods
    
    private func setupCommon() {
        view.backgroundColor = .dim
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    private func setupAlertView(
        title: String,
        message: String,
        leftActionText: String,
        rightActionText: String
    ) {
        titleLabel.text = title
        titleLabel.applyTypography(with: .titleSmall)
        messageLabel.text = message
        messageLabel.applyTypography(with: .bodyLargeRegular)
        
        leftButton = AssistiveButton(title: leftActionText, font: .labelLargeSemiBold)
        rightButton = SolidButton(title: rightActionText, font: .labelLargeSemiBold)
        
        guard let leftButton = leftButton, let rightButton = rightButton else { return }
        [leftButton, rightButton].forEach { buttonContainer.addArrangedSubview($0) }
    }
    
    private func setupActions(
        leftActionCompletion: (() -> Void)? = nil,
        rightActionCompletion: (() -> Void)? = nil
    ) {
        guard let leftButton = leftButton, let rightButton = rightButton else { return }
        
        self.leftActionCompletion = leftActionCompletion
        self.rightActionCompletion = rightActionCompletion
        
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.center.equalToSuperview()
        }
        
        [titleLabel, messageLabel, buttonContainer].forEach {
            containerView.addArrangedSubview($0)
        }
        
        buttonContainer.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Helper Methods
    
    private func createLabel(with title: String? = nil) -> UILabel {
        let label = UILabel()
        label.textColor = .labelNormal
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.configuration = .plain()
        button.backgroundColor = .clear
        button.tintColor = .labelNormal
        return button
    }
    
    // MARK: - Animation Methods
    
    func prepareForAnimation() {
        view.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)
    }
    
    func animateIn(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.view.alpha = 1.0
            self?.containerView.transform = .identity
        } completion: { _ in
            completion?()
        }
    }
    
    func animateOut(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.view.alpha = 0.0
        } completion: { _ in
            completion?()
        }
    }
    
    // MARK: - Action Methods
    
    @objc private func leftButtonTapped() {
        dismiss(animated: true, completion: leftActionCompletion)
    }
    
    @objc private func rightButtonTapped() {
        dismiss(animated: true, completion: rightActionCompletion)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension AlertViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return AlertAnimator(alertViewController: self, isPresenting: true)
    }
    
    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return AlertAnimator(alertViewController: self, isPresenting: false)
    }
}

// MARK: - Unified Animator

class AlertAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let alertViewController: AlertViewController
    private let isPresenting: Bool
    
    init(alertViewController: AlertViewController, isPresenting: Bool) {
        self.alertViewController = alertViewController
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        if isPresenting {
            return 0.2
        } else {
            return 0.1
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            guard let toView = transitionContext.view(forKey: .to) else { return }
            transitionContext.containerView.addSubview(toView)
            alertViewController.prepareForAnimation()
            alertViewController.animateIn {
                transitionContext.completeTransition(true)
            }
        } else {
            alertViewController.animateOut {
                transitionContext.completeTransition(true)
            }
        }
    }
}
