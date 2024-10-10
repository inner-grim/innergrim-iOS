//
//  SceneDelegate.swift
//  innergrim
//
//  Created by 지연 on 9/21/24.
//

import UIKit

import Feature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
