//
//  UserDataStorage.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import Foundation

final class UserDataStorage {
    private init() {}
    
    @UserDefaultsData(key: "isOnboardingCompleted", defaultValue: false)
    static var isOnboardingCompleted: Bool
    
    @UserDefaultsData(key: "isLogin", defaultValue: false)
    static var isLogin: Bool
}
