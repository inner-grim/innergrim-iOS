//
//  MainCoordinator.swift
//  innergrim
//
//  Created by 지연 on 10/15/24.
//

import UIKit

import Feature
import Shared

final class MainCoordinator: Coordinator {
    private let window: UIWindow
    private let factory: MainFactory
    
    init(window: UIWindow, factory: MainFactory) {
        self.window = window
        self.factory = factory
    }
    
    func start() {
        showChatViewController()
    }
    
    private func showChatViewController() {
        let viewController = ChatViewController()
        window.rootViewController = UINavigationController(rootViewController: viewController)
    }
    
    private func showMainTabBarController() {
        let mainTabBarController = MainTabBarController(factory: factory)
        window.rootViewController = mainTabBarController
    }
}
