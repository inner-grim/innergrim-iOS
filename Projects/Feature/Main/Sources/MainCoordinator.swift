//
//  MainCoordinator.swift
//  FeatureMain
//
//  Created by 지연 on 10/10/24.
//

import UIKit

import Shared

public final class MainCoordinator: Coordinator {
    private let window: UIWindow
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        showMainTabBarController()
    }
    
    private func showMainTabBarController() {
        let mainTabBarController = MainTabBarController()
        window.rootViewController = mainTabBarController
    }
}
