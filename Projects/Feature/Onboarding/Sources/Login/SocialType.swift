//
//  SocialType.swift
//  Onboarding
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Shared

public enum SocialType {
    case apple
    case goole
    case kakao
    
    public var description: String {
        switch self {
        case .apple:    "Apple"
        case .goole:    "Google"
        case .kakao:    "Kakao"
        }
    }
    
    public var image: UIImage {
        switch self {
        case .apple:    .apple
        case .goole:    .google
        case .kakao:    .kakao
        }
    }
    
    public var textColor: UIColor {
        switch self {
        case .apple:    .white
        case .goole:    .labelNeutral
        case .kakao:    .kakaoLabel
        }
    }
    
    public var backgroundColor: UIColor {
        switch self {
        case .apple:    .appleFill
        case .goole:    .white
        case .kakao:    .kakaoFill
        }
    }
    
    public var borderColor: UIColor {
        switch self {
        case .apple:    .appleFill
        case .goole:    .lineNormal
        case .kakao:    .kakaoFill
        }
    }
}
