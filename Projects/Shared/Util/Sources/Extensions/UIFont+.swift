//
//  UIFont+.swift
//  SharedUtil
//
//  Created by 지연 on 11/5/24.
//

import UIKit

import SharedDesignSystem

extension UIFont {
    public static var headingLarge: UIFont {
        SharedDesignSystemFontFamily.Pretendard.bold.font(size: 36)
    }
    
    public static var headingMedium: UIFont {
        SharedDesignSystemFontFamily.Pretendard.bold.font(size: 32)
    }
    
    public static var headingSmall: UIFont {
        SharedDesignSystemFontFamily.Pretendard.bold.font(size: 28)
    }
    
    public static var titleLarge: UIFont {
        SharedDesignSystemFontFamily.Pretendard.bold.font(size: 24)
    }
    
    public static var titleMedium: UIFont {
        SharedDesignSystemFontFamily.Pretendard.bold.font(size: 20)
    }
    
    public static var titleSmall: UIFont {
        SharedDesignSystemFontFamily.Pretendard.bold.font(size: 18)
    }
    
    public static var bodyLargeRegular: UIFont {
        SharedDesignSystemFontFamily.Pretendard.regular.font(size: 16)
    }
    
    public static var bodyLargeSemiBold: UIFont {
        SharedDesignSystemFontFamily.Pretendard.semiBold.font(size: 16)
    }
    
    public static var bodyMediumRegular: UIFont {
        SharedDesignSystemFontFamily.Pretendard.regular.font(size: 14)
    }
    
    public static var bodyMediumSemiBold: UIFont {
        SharedDesignSystemFontFamily.Pretendard.semiBold.font(size: 14)
    }
    
    public static var labelLargeMedium: UIFont {
        SharedDesignSystemFontFamily.Pretendard.medium.font(size: 16)
    }
    
    public static var labelLargeSemiBold: UIFont {
        SharedDesignSystemFontFamily.Pretendard.semiBold.font(size: 16)
    }
    
    public static var labelMediumMedium: UIFont {
        SharedDesignSystemFontFamily.Pretendard.medium.font(size: 14)
    }
    
    public static var labelMediumSemiBold: UIFont {
        SharedDesignSystemFontFamily.Pretendard.semiBold.font(size: 14)
    }

    public static var labelSmallMedium: UIFont {
        SharedDesignSystemFontFamily.Pretendard.medium.font(size: 12)
    }
    
    public static var labelSmallSemiBold: UIFont {
        SharedDesignSystemFontFamily.Pretendard.semiBold.font(size: 12)
    }
    
    public static var labelXSmallMedium: UIFont {
        SharedDesignSystemFontFamily.Pretendard.medium.font(size: 10)
    }
    
    public static var labelXSmallSemiBold: UIFont {
        SharedDesignSystemFontFamily.Pretendard.semiBold.font(size: 10)
    }
}
