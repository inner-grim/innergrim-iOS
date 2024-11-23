//
//  MainFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Shared

final class MainFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let tabBarController: UITabBarController
    private let mainDIContainer: MainDIContainer
    
    init(
        tabBarController: UITabBarController,
        mainDIContainer: MainDIContainer
    ) {
        self.tabBarController = tabBarController
        self.mainDIContainer = mainDIContainer
    }
    
    func start() {
    }
}
