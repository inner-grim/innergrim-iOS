//
//  CalendarDIContainer.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

final class CalendarDIContainer {
    struct Dependencies {}

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - View Models

    // MARK: - View Controllers
    
    func makeCalendarViewController() -> UIViewController {
        return UIViewController()
    }
}
