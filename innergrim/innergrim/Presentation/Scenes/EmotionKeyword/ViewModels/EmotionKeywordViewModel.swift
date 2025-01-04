//
//  EmotionKeywordViewModel.swift
//  innergrim
//
//  Created by 지연 on 1/4/25.
//

import Combine
import Foundation

final class EmotionKeywordViewModel: ViewModel {
    enum Action {
        case viewDidLoad
        case emotionKeywordCellDidTap(indexPath: IndexPath)
        case doneButtonDidTap
    }
    
    struct State {
        var emotionKeywords = CurrentValueSubject<[EmotionKeywordSectionViewModel], Never>([])
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state = State()
    
    private var selectedSectionIndex: Int?
    private var selectedCellCount: Int = 0
    
    // MARK: - Init
    
    init() {
        actionSubject
            .sink { [weak self] action in
                self?.handleAction(action)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .viewDidLoad:
            initializeState()
        case .emotionKeywordCellDidTap(let indexPath):
            updateEmotionKeywords(indexPath: indexPath)
        case .doneButtonDidTap:
            validateSelectedEmotionKeywords()
        }
    }
    
    private func initializeState() {
        let sectionViewModels = EmotionKeyword.Category.allCases.map { category in
            EmotionKeywordSectionViewModel(
                category: category,
                cellViewModels: EmotionKeyword.allCases
                    .filter { $0.category == category }
                    .map { EmotionKeywordCellViewModel(emotion: $0) }
            )
        }
        state.emotionKeywords.send(sectionViewModels)
    }
    
    private func updateEmotionKeywords(indexPath: IndexPath) {
        // 이미 선택된 대분류가 있을 경우, 다른 대분류 선택 방지
        if selectedSectionIndex != nil, selectedSectionIndex != indexPath.section { return }
        
        var emotionKeywords = state.emotionKeywords.value
        // 선택된 키워드 상태 토글
        var cellViewModel = emotionKeywords[indexPath.section].cellViewModels[indexPath.row]
        switch cellViewModel.state {
        case .normal:
            cellViewModel.state = .selected
            selectedCellCount += 1
        case .selected:
            cellViewModel.state = .normal
            selectedCellCount -= 1
        default:
            break
        }
        emotionKeywords[indexPath.section].cellViewModels[indexPath.row] = cellViewModel
        // 선택된 키워드에 따라 상태 변경
        selectedSectionIndex = selectedCellCount > 0 ? indexPath.section : nil
        if let selectedIndex = selectedSectionIndex {
            updateUnselectedSectionStateDisabled(selectedIndex, emotionKeywords)
        } else {
            updateAllSectionStateNormal(emotionKeywords)
        }
    }
    
    private func updateUnselectedSectionStateDisabled(
        _ selectedIndex: Int,
        _ emotionKeywords: [EmotionKeywordSectionViewModel]
    ) {
        let updatedEmotionKeywords = emotionKeywords.map { emotion in
            var updatedEmotion = emotion
            if updatedEmotion.category != EmotionKeyword.Category.allCases[selectedIndex] {
                updatedEmotion.cellViewModels = updatedEmotion.cellViewModels.map { model in
                    var updateModel = model
                    updateModel.state = .disabled
                    return updateModel
                }
            }
            return updatedEmotion
        }
        state.emotionKeywords.send(updatedEmotionKeywords)
    }
    
    private func updateAllSectionStateNormal(
        _ emotionKeywords: [EmotionKeywordSectionViewModel]
    ) {
        let updatedEmotionKeywords = emotionKeywords.map { keyword in
            var updatedKeyword = keyword
            updatedKeyword.cellViewModels = updatedKeyword.cellViewModels.map { model in
                var updatedModel = model
                updatedModel.state = .normal
                return updatedModel
            }
            return updatedKeyword
        }
        state.emotionKeywords.send(updatedEmotionKeywords)
    }
    
    private func validateSelectedEmotionKeywords() {
        if selectedCellCount < 1 {
            Toaster.makeToast("최소 1개 이상 선택해 주세요")
        } else if selectedCellCount > 3 {
            Toaster.makeToast("최대 3개까지 선택 가능해요")
        } else {
            // 바텀시트
        }
    }
}
