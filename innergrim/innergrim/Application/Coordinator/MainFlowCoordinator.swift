//
//  MainFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

protocol MainFlowCoordinatorDelegate: AnyObject {
    func mainFlowDidFinish(_ coordinator: MainFlowCoordinator)
}

final class MainFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var delegate: MainFlowCoordinatorDelegate?
    
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
        showHomeViewController()
    }
    
    private func showHomeViewController() {
        let viewController = mainDIContainer.makeHomeViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showEmotionKeywordViewController() {
        let viewController = mainDIContainer.makeEmotionKeywordViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showEmotionScaleViewController(emotionKeywords: [String]) {
        let viewController = mainDIContainer.makeEmotionScaleViewController(
            emotionKeywords: emotionKeywords
        )
        viewController.delegate = self
        navigationController.present(viewController, animated: false)
    }
    
    private func showChatViewController(chatStartMessage: String) {
        let viewController = mainDIContainer.makeChatViewController(
            chatStartMessage: chatStartMessage
        )
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showPictureDiaryViewController() {
        let viewController = mainDIContainer.makePictureDiaryViewController()
        viewController.modalPresentationStyle = .overFullScreen
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showSettingsViewController() {
        let viewController = mainDIContainer.makeSettingsViewController()
        viewController.delegate = self
        viewController.modalPresentationStyle = .overFullScreen
        navigationController.present(viewController, animated: true)
    }
}

extension MainFlowCoordinator: HomeViewControllerDelegate {
    func navigateToKeywordViewController() {
        showEmotionKeywordViewController()
    }
    
    func navigateToPictureDiaryViewController() {
        showPictureDiaryViewController()
    }
    
    func navigateToSettingsViewController() {
        showSettingsViewController()
    }
}

extension MainFlowCoordinator: EmotionKeywordViewControllerDelegate {
    func navigateToEmotionScaleViewController(emotionKeywords: [String]) {
        showEmotionScaleViewController(emotionKeywords: emotionKeywords)
    }
}

extension MainFlowCoordinator: EmotionScaleViewControllerDelegate {
    func navigateToChatViewController(chatStartMessage: String) {
        showChatViewController(chatStartMessage: chatStartMessage)
    }
}

extension MainFlowCoordinator: SettingsViewControllerDelegate {
    func moveToLogin() {
        delegate?.mainFlowDidFinish(self)
    }
}
