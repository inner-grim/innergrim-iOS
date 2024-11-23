//
//  ChatViewController.swift
//  Chat
//
//  Created by 지연 on 11/23/24.
//

import Combine
import UIKit

import FeatureChatInterface
import Shared

public final class ChatViewController: BaseViewController<ChatView> {
    public weak var delegate: ChatViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: "채팅")
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        dismissButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.chatViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
}
