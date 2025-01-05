//
//  HomeViewModel.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import Combine
import Foundation

final class HomeViewModel: NSObject, ViewModel {
    enum Action {
    }
    
    struct State {
        var calendarCellViewModels = CurrentValueSubject<[CalendarCellViewModel], Never>([])
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state = State()
    
    private var nickname: String?
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        let cellViewModels = [
            CalendarCellViewModel(type: .empty, imageURL: nil, day: ""),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "1"),
            CalendarCellViewModel(type: .diaryWritten, imageURL: nil, day: "2"),
            CalendarCellViewModel(type: .diaryWritten, imageURL: nil, day: "3"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "4"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "5"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "6"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "7"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "8"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "9"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "10"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "11"),
            CalendarCellViewModel(type: .diaryWritten, imageURL: nil, day: "12"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "13"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "14"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "15"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "16"),
            CalendarCellViewModel(type: .diaryWritten, imageURL: nil, day: "17"),
            CalendarCellViewModel(type: .diaryWritten, imageURL: nil, day: "18"),
            CalendarCellViewModel(type: .diaryWritten, imageURL: nil, day: "19"),
            CalendarCellViewModel(type: .diaryWritten, imageURL: nil, day: "20"),
            CalendarCellViewModel(type: .diaryWritten, imageURL: nil, day: "21"),
            CalendarCellViewModel(type: .diaryWritten, imageURL: nil, day: "22"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "23"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "24"),
            CalendarCellViewModel(type: .today, imageURL: nil, day: "25"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "26"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "27"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "28"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "29"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "30"),
            CalendarCellViewModel(type: .noDiary, imageURL: nil, day: "31"),
        ]
        state.calendarCellViewModels.send(cellViewModels)
        
        setupActionBindings()
    }
    
    private func setupActionBindings() {
        actionSubject.sink { [weak self] action in
            switch action {
            }
        }
        .store(in: &cancellables)
    }
}
