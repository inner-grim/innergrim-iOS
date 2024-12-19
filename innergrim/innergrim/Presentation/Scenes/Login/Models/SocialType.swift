//
//  SocialType.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

enum SocialType {
    case apple
    case goole
    case kakao
}

extension SocialType {
    var description: String {
        switch self {
        case .apple:    "Apple"
        case .goole:    "Google"
        case .kakao:    "Kakao"
        }
    }
    
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
        case .apple:    .appleFill
        case .goole:    .white
        case .kakao:    .kakaoFill
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .apple:    .appleFill
        case .goole:    .lineNormal
        case .kakao:    .kakaoFill
        }
    }
}
