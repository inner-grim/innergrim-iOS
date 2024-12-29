//
//  MainDIContainer.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class MainDIContainer {
    // MARK: - View Models
    
    private func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
    
    private func makeChatViewModel() -> ChatViewModel {
        return ChatViewModel()
    }

    // MARK: - View Controllers
    
    func makeHomeViewController() -> HomeViewController {
        let viewModel = makeHomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
    
    func makeKeywordViewController() -> EmotionViewController {
        let viewController = EmotionViewController()
        return viewController
    }
    
    func makeChatViewController() -> ChatViewController {
        let viewModel = makeChatViewModel()
        let viewController = ChatViewController(viewModel: viewModel)
        return viewController
    }
    
    func makePictureDiaryViewController() -> PictureDiaryViewController {
        let viewController = PictureDiaryViewController()
        return viewController
    }
    
    func makeSettingsViewController() -> SettingsViewController {
        let viewController = SettingsViewController()
        return viewController
    }
}
