//
//  MainCoordinator.swift
//  innergrim
//
//  Created by 지연 on 10/15/24.
//

import UIKit

import Shared

final class MainCoordinator: Coordinator {
    private let window: UIWindow
    private let factory: MainFactory
    
    init(window: UIWindow, factory: MainFactory) {
        self.window = window
        self.factory = factory
    }
    
    func start() {
        showMainTabBarController()
    }
    
    private func showMainTabBarController() {
        let mainTabBarController = MainTabBarController(factory: factory)
        window.rootViewController = mainTabBarController
    }
}
