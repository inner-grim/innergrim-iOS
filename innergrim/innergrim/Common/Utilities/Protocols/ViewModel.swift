//
//  ViewModel.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Combine

protocol ViewModel {
    associatedtype Action
    associatedtype State
    
    var actionSubject: PassthroughSubject<Action, Never> { get }
    var cancellables: Set<AnyCancellable> { get set }
    var state: State { get }
    
    func send(_ action: Action)
}

extension ViewModel {
    func send(_ action: Action) {
        actionSubject.send(action)
    }
}
