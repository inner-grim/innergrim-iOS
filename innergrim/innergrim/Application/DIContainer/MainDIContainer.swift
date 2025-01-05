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
    
    private func makeEmotionKeywordViewModel() -> EmotionKeywordViewModel {
        return EmotionKeywordViewModel()
    }
    
    private func makeEmotionScaleViewModel(emotionKeywords: [String]) -> EmotionScaleViewModel {
        return EmotionScaleViewModel(emotionKeywords: emotionKeywords)
    }
    
    private func makeChatViewModel(chatStartMessage: String) -> ChatViewModel {
        return ChatViewModel(chatStartMessage: chatStartMessage)
    }
    
    private func makeSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel()
    }

    // MARK: - View Controllers
    
    func makeHomeViewController() -> HomeViewController {
        let viewModel = makeHomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
    
    func makeEmotionKeywordViewController() -> EmotionKeywordViewController {
        let viewModel = makeEmotionKeywordViewModel()
        let viewController = EmotionKeywordViewController(viewModel: viewModel)
        return viewController
    }
    
    func makeEmotionScaleViewController(emotionKeywords: [String]) -> EmotionScaleViewController {
        let viewModel = makeEmotionScaleViewModel(emotionKeywords: emotionKeywords)
        let viewController = EmotionScaleViewController(viewModel: viewModel)
        return viewController
    }
    
    func makeChatViewController(chatStartMessage: String) -> ChatViewController {
        let viewModel = makeChatViewModel(chatStartMessage: chatStartMessage)
        let viewController = ChatViewController(viewModel: viewModel)
        return viewController
    }
    
    func makePictureDiaryViewController() -> PictureDiaryViewController {
        let viewController = PictureDiaryViewController()
        return viewController
    }
    
    func makeSettingsViewController() -> SettingsViewController {
        let viewModel = makeSettingsViewModel()
        let viewController = SettingsViewController(viewModel: viewModel)
        return viewController
    }
}
