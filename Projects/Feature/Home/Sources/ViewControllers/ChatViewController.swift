//
//  ChatViewController.swift
//  FeatureHome
//
//  Created by 지연 on 11/6/24.
//

import Combine
import UIKit

import Shared

public final class ChatViewController: BaseViewController<ChatView> {
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "채팅")
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        keyboardWillShowPublisher
            .sink { [weak self] keyboardHeight in
                self?.adjustMessageTextFieldPosition(keyboardHeight: keyboardHeight)
            }.store(in: &cancellables)
        
        keyboardWillHidePublisher
            .sink { [weak self] _ in
                self?.resetMessageTextFieldPosition()
            }.store(in: &cancellables)
    }
    
    private func adjustMessageTextFieldPosition(keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.35) {
            self.messageTextField.transform = CGAffineTransform(
                translationX: 0,
                y: 36 - keyboardHeight
            )
        }
    }
    
    private func resetMessageTextFieldPosition() {
        UIView.animate(withDuration: 0.35) {
            self.messageTextField.transform = .identity
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

private extension ChatViewController {
    var messageTextField: MessageTextField {
        contentView.messageTextField
    }
}
