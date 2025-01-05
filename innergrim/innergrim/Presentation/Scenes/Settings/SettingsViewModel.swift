//
//  SettingsViewModel.swift
//  innergrim
//
//  Created by 지연 on 1/5/25.
//

import Combine
import Foundation

final class SettingsViewModel: ViewModel {
    enum Action {
        case logout
        case withdraw
    }
    
    struct State {
        var moveToLogin = PassthroughSubject<Void, Never>()
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state = State()
    
    // MARK: - Init
    
    init() {
        actionSubject.sink { [weak self] action in
            self?.handleAction(action)
        }
        .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .logout:
            logout()
        case .withdraw:
            withdraw()
        }
    }
    
    private func logout() {
        KeychainService.clear()
        UserDataStorage.isLogin = false
        state.moveToLogin.send()
    }
    
    private func withdraw() {
        let target = MemberAPI.withdraw
        APIService.request(target, responseType: CommonResponse.self)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    KeychainService.clear()
                    UserDataStorage.clear()
                    self?.state.moveToLogin.send()
                case .failure(let error):
                    print("회원 탈퇴 실패", error.localizedDescription)
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
}
