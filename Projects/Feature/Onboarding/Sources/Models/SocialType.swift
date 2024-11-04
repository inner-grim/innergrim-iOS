//
//  SocialType.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/5/24.
//

import UIKit

public enum SocialType: String {
    case apple = "Apple"
    case goole = "Google"
    case kakao = "Kakao"
    
    var image: UIImage {
        switch self {
        case .apple:    .apple
        case .goole:    .google
        case .kakao:    .kakao
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .apple:    .white
        case .goole:    .labelNeutral
        case .kakao:    .kakaoLabel
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .apple:    .gray850
        case .goole:    .white
        case .kakao:    .kakaoFill
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .apple:    .gray850
        case .goole:    .lineNormal
        case .kakao:    .kakaoFill
        }
    }
}
