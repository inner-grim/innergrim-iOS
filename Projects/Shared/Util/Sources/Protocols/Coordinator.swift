//
//  Coordinator.swift
//  SharedUtil
//
//  Created by 지연 on 11/23/24.
//

import Foundation

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    public func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    public func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
