//
//  MainDIContainer.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class MainDIContainer {
    // MARK: - DI Containers
    
    func makeHomeDIContainer() -> HomeDIContainer {
        return HomeDIContainer()
    }
}
