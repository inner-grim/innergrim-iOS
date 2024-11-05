//
//  ChatViewController.swift
//  FeatureHome
//
//  Created by 지연 on 11/6/24.
//

import UIKit

import Shared

public final class ChatViewController: BaseViewController<ChatView> {
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "채팅")
    }
}
