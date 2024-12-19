//
//  MainTabBarController.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class MainTabBarController: UITabBarController {
    // MARK: - Components
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .lineLight
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    // MARK: - Configure Methods
    
    private func configureTabBar() {
        tabBar.tintColor = .primaryNormal
        tabBar.unselectedItemTintColor = .labelAssistive
        tabBar.backgroundColor = .white
        
        tabBar.addSubview(line)
        line.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
