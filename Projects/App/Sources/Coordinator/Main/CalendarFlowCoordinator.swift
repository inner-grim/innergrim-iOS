//
//  CalendarFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Shared

final class CalendarFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let calendarDIContainer: CalendarDIContainer
    
    init(
        navigationController: UINavigationController,
        calendarDIContainer: CalendarDIContainer
    ) {
        self.navigationController = navigationController
        self.calendarDIContainer = calendarDIContainer
    }
    
    func start() {
        showCalendarViewController()
    }
    
    private func showCalendarViewController() {
        let viewController = calendarDIContainer.makeCalendarViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
