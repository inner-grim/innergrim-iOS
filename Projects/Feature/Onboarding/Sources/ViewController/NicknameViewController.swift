//
//  NicknameViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/6/24.
//

import Combine
import UIKit

import Shared

public protocol NicknameViewControllerDelegate: AnyObject {
    func nicknameViewControllerDidFinish()
}

public final class NicknameViewController: BaseViewController<NicknameView> {
    public weak var delegate: NicknameViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        keyboardWillShowPublisher
            .sink { [weak self] keyboardHeight in
                self?.adjustNextButtonPosition(keyboardHeight: keyboardHeight)
            }.store(in: &cancellables)
        
        keyboardWillHidePublisher
            .sink { [weak self] _ in
                self?.resetNextButtonPosition()
            }.store(in: &cancellables)
        
        nextButton.tapPublisher
            .sink { [weak self] in
                self?.view.endEditing(true)
                self?.delegate?.nicknameViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
    
    private func adjustNextButtonPosition(keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.35) {
            self.nextButton.transform = CGAffineTransform(
                translationX: 0,
                y: 58 - keyboardHeight
            )
        }
    }
    
    private func resetNextButtonPosition() {
        UIView.animate(withDuration: 0.35) {
            self.nextButton.transform = .identity
        }
    }
        
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

private extension NicknameViewController {
    var nicknameTextField: ValidationTextField {
        contentView.textField
    }
    
    var nextButton: SolidButton {
        contentView.nextButton
    }
}
