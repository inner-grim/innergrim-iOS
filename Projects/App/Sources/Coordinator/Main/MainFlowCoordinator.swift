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
        // 탭바 설정
        let homeNavigation = UINavigationController()
        let calendarNavigation = UINavigationController()
        let statNavigation = UINavigationController()
        let profileNavigation = UINavigationController()
        
        homeNavigation.tabBarItem = UITabBarItem(
            title: "홈",
            image: .calendar,
            selectedImage: .calendar
        )
        calendarNavigation.tabBarItem = UITabBarItem(
            title: "캘린더",
            image: .calendar,
            selectedImage: .calendar
        )
        statNavigation.tabBarItem = UITabBarItem(
            title: "통계",
            image: .stat,
            selectedImage: .stat
        )
        profileNavigation.tabBarItem = UITabBarItem(
            title: "프로필",
            image: .profile,
            selectedImage: .profile
        )
        
        tabBarController.setViewControllers(
            [homeNavigation, calendarNavigation, statNavigation, profileNavigation],
            animated: false
        )
        
        // 코디네이터 설정
        let homeCoordinator = HomeFlowCoordinator(
            navigationController: homeNavigation,
            homeDIContainer: mainDIContainer.makeHomeDIContainer()
        )
        let calendarCoordinator = HomeFlowCoordinator(
            navigationController: calendarNavigation,
            homeDIContainer: mainDIContainer.makeHomeDIContainer()
        )
        let statCoordinator = HomeFlowCoordinator(
            navigationController: statNavigation,
            homeDIContainer: mainDIContainer.makeHomeDIContainer()
        )
        let profileCoordinator = HomeFlowCoordinator(
            navigationController: profileNavigation,
            homeDIContainer: mainDIContainer.makeHomeDIContainer()
        )
        
        store(coordinator: homeCoordinator)
        store(coordinator: calendarCoordinator)
        store(coordinator: statCoordinator)
        store(coordinator: profileCoordinator)
        
        homeCoordinator.start()
        calendarCoordinator.start()
        statCoordinator.start()
        profileCoordinator.start()
    }
}
