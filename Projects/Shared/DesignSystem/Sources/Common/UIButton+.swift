//
//  UIButton+.swift
//  SharedDesignSystem
//
//  Created by 지연 on 11/5/24.
//

import UIKit

extension UIButton {
    func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
