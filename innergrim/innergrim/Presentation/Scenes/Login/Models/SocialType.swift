//
//  SocialType.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

enum SocialType: String {
    case apple
    case google
    case kakao
}

extension SocialType {
    var description: String {
        switch self {
        case .apple:    "Apple"
        case .google:    "Google"
        case .kakao:    "Kakao"
        }
    }
    
    var image: UIImage {
        switch self {
        case .apple:    .apple
        case .google:    .google
        case .kakao:    .kakao
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .apple:    .white
        case .google:    .labelNeutral
        case .kakao:    .kakaoLabel
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .apple:    .appleFill
        case .google:    .white
        case .kakao:    .kakaoFill
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .apple:    .appleFill
        case .google:    .lineNormal
        case .kakao:    .kakaoFill
        }
    }
}
