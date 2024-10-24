//
//  MainTabBarController.swift
//  innergrim
//
//  Created by 지연 on 10/15/24.
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

final class MainTabBarController: UITabBarController {
    private let factory: MainFactory
    
    // MARK: - Init
    
    init(factory: MainFactory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - Setup Methods
    
    private func setupTabBar() {
        tabBar.backgroundColor = .systemBackground
        viewControllers = MainTab.allCases.map { tab in
            let viewController: UIViewController
            
            switch tab {
            case .home:     viewController = factory.makeHomeViewController()
            case .stat:     viewController = factory.makeStatViewController()
            case .profile:  viewController = factory.makeProfileViewController()
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
