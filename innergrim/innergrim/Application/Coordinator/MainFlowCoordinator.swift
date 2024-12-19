//
//  MainFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class MainFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let mainDIContainer: MainDIContainer
    
    init(
        navigationController: UINavigationController,
        mainDIContainer: MainDIContainer
    ) {
        self.navigationController = navigationController
        self.mainDIContainer = mainDIContainer
    }
    
    func start() {
        navigationController.isNavigationBarHidden = true
        showMainTabBarController()
    }
    
    func showMainTabBarController() {
        let tabBarController = MainTabBarController()
        
        // 각 탭의 NavigationController 설정
        let homeNavigation = UINavigationController()
        let calendarNavigation = UINavigationController()
        let statNavigation = UINavigationController()
        let profileNavigation = UINavigationController()
        
        homeNavigation.tabBarItem = UITabBarItem(
            title: "홈",
            image: .calendar,
            selectedImage: .calendar
        )
        profileNavigation.tabBarItem = UITabBarItem(
            title: "프로필",
            image: .profile,
            selectedImage: .profile
        )
        
        tabBarController.setViewControllers(
            [homeNavigation, profileNavigation],
            animated: false
        )
        
        // 각 탭의 Coordinator 설정
        let homeCoordinator = HomeFlowCoordinator(
            navigationController: homeNavigation,
            homeDIContainer: mainDIContainer.makeHomeDIContainer()
        )
        store(coordinator: homeCoordinator)
        homeCoordinator.start()
        
        navigationController.pushViewController(tabBarController, animated: false)
    }
}
