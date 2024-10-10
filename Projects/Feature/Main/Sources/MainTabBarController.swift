//
//  MainTabBarController.swift
//  FeatureMain
//
//  Created by 지연 on 10/10/24.
//

import UIKit

enum MainTab: CaseIterable {
    case home
    case stat
    case profile
    
    var title: String {
        switch self {
        case .home:     "홈"
        case .stat:     "전시"
        case .profile:  "프로필"
        }
    }
    
    var icon: String {
        switch self {
        case .home:     "house"
        case .stat:     "books.vertical"
        case .profile:  "person"
        }
    }
}

public final class MainTabBarController: UITabBarController {
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - Setup Methods
    
    private func setupTabBar() {
        tabBar.backgroundColor = .systemBackground
        viewControllers = MainTab.allCases.map { tab in
            let viewController: UIViewController
            
            switch tab {
            case .home:     viewController = HomeViewController()
            case .stat:     viewController = StatViewController()
            case .profile:  viewController = ProfileViewController()
            }
            
            viewController.tabBarItem = UITabBarItem(
                title: tab.title,
                image: UIImage(systemName: tab.icon),
                selectedImage: nil
            )
            
            return UINavigationController(rootViewController: viewController)
        }
    }
}
