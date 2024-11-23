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
        
        // 각 탭의 Coordinator 설정
        let homeCoordinator = HomeFlowCoordinator(
            navigationController: homeNavigation,
            homeDIContainer: mainDIContainer.makeHomeDIContainer()
        )
        homeCoordinator.delegate = self
        store(coordinator: homeCoordinator)
        homeCoordinator.start()
        
        let calendarCoordinator = CalendarFlowCoordinator(
            navigationController: calendarNavigation,
            calendarDIContainer: mainDIContainer.makeCalendarDIContainer()
        )
        store(coordinator: calendarCoordinator)
        calendarCoordinator.start()
        
        let statCoordinator = StatFlowCoordinator(
            navigationController: statNavigation,
            statDIContainer: mainDIContainer.makeStatDIContainer()
        )
        store(coordinator: statCoordinator)
        statCoordinator.start()
        
        let profileCoordinator = ProfileFlowCoordinator(
            navigationController: profileNavigation,
            profileDIContainer: mainDIContainer.makeProfileDIContainer()
        )
        store(coordinator: profileCoordinator)
        profileCoordinator.start()
        
        navigationController.pushViewController(tabBarController, animated: false)
    }
    
    private func showChatFlow() {
        let chatDIContainer = mainDIContainer.makeChatDIContainer()
        
        let chatCoordinator = ChatFlowCoordinator(
            navigationController: navigationController,
            chatDIContainer: chatDIContainer
        )
        
        store(coordinator: chatCoordinator)
        chatCoordinator.start()
    }
}

extension MainFlowCoordinator: HomeFlowCoordinatorDelegate {
    func homeFlowCoordinatorDidRequestChatFlow() {
        showChatFlow()
    }
}

extension MainFlowCoordinator: ChatFlowCoordinatorDelegate {
    func chatFlowDidFinish(_ coordinator: ChatFlowCoordinator) {
        free(coordinator: coordinator)
    }
}
