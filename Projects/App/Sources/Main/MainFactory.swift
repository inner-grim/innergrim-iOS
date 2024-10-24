//
//  MainFactory.swift
//  innergrim
//
//  Created by 지연 on 10/15/24.
//

import UIKit

import Feature

final class MainFactory {
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController()
    }
    
    func makeStatViewController() -> StatViewController {
        return StatViewController()
    }
    
    func makeProfileViewController() -> ProfileViewController {
        return ProfileViewController()
    }
}
