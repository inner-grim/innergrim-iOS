//
//  HomeDIContainer.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class HomeDIContainer {
    // MARK: - View Models

    // MARK: - View Controllers
    
    func makeHomeViewController() -> HomeViewController {
        let viewController = HomeViewController()
        return viewController
    }
}
