//
//  MainDIContainer.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

final class MainDIContainer {
    struct Dependencies {}

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - DI Containers
    
    func makeHomeDIContainer() -> HomeDIContainer {
        let dependencies = HomeDIContainer.Dependencies()
        return HomeDIContainer(dependencies: dependencies)
    }
    
    func makeCalendarDIContainer() -> CalendarDIContainer {
        let dependencies = CalendarDIContainer.Dependencies()
        return CalendarDIContainer(dependencies: dependencies)
    }
    
    func makeStatDIContainer() -> StatDIContainer {
        let dependencies = StatDIContainer.Dependencies()
        return StatDIContainer(dependencies: dependencies)
    }
    
    func makeProfileDIContainer() -> ProfileDIContainer {
        let dependencies = ProfileDIContainer.Dependencies()
        return ProfileDIContainer(dependencies: dependencies)
    }
    
    func makeChatDIContainer() -> ChatDIContainer {
        let dependencies = ChatDIContainer.Dependencies()
        return ChatDIContainer(dependencies: dependencies)
    }
    
    
}
