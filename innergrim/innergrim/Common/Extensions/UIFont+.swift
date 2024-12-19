//
//  Fonts.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

private enum PretendardWeight: String {
    case bold = "Bold"
    case medium = "Medium"
    case regular = "Regular"
    case semibold = "SemiBold"
}

extension UIFont {
    private static func pretendard(weight: PretendardWeight, size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-\(weight.rawValue)", size: size)!
    }
    
    static var headingLarge: UIFont {
        return pretendard(weight: .bold, size: 36)
    }
    
    static var headingMedium: UIFont {
        return pretendard(weight: .bold, size: 32)
    }
    
    static var headingSmall: UIFont {
        return pretendard(weight: .bold, size: 28)
    }
    
    static var titleLarge: UIFont {
        return pretendard(weight: .bold, size: 24)
    }
    
    static var titleMedium: UIFont {
        return pretendard(weight: .bold, size: 20)
    }
    
    static var titleSmall: UIFont {
        return pretendard(weight: .bold, size: 18)
    }
    
    static var bodyLargeRegular: UIFont {
        return pretendard(weight: .regular, size: 16)
    }
    
    static var bodyLargeSemiBold: UIFont {
        return pretendard(weight: .semibold, size: 16)
    }
    
    static var bodyMediumRegular: UIFont {
        return pretendard(weight: .regular, size: 14)
    }
    
    static var bodyMediumSemiBold: UIFont {
        return pretendard(weight: .semibold, size: 14)
    }
    
    static var labelLargeMedium: UIFont {
        return pretendard(weight: .medium, size: 16)
    }
    
    static var labelLargeSemiBold: UIFont {
        return pretendard(weight: .semibold, size: 16)
    }
    
    static var labelMediumMedium: UIFont {
        return pretendard(weight: .medium, size: 14)
    }
    
    static var labelMediumSemiBold: UIFont {
        return pretendard(weight: .semibold, size: 14)
    }
    
    static var labelSmallMedium: UIFont {
        return pretendard(weight: .medium, size: 12)
    }
    
    static var labelSmallSemiBold: UIFont {
        return pretendard(weight: .semibold, size: 12)
    }
    
    static var labelXSmallMedium: UIFont {
        return pretendard(weight: .medium, size: 10)
    }
    
    static var labelXSmallSemiBold: UIFont {
        return pretendard(weight: .semibold, size: 10)
    }
    
    static var labelDiary: UIFont {
        return UIFont(name: "HakgyoansimKkokkomaOTFR", size: 20)!
    }
}
