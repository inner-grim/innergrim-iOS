//
//  GenderType.swift
//  Onboarding
//
//  Created by 지연 on 11/23/24.
//

import Foundation

public enum GenderType: CaseIterable {
    case male
    case female
    
    public var description: String {
        switch self {
        case .male:     "남성"
        case .female:   "여성"
        }
    }
}
