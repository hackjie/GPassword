//
//  Extensions.swift
//  GPassword
//
//  Created by leoli on 2018/4/27.
//  Copyright © 2018年 leoli. All rights reserved.
//

import UIKit

/// Convenience UIColor
extension UIColor {
    convenience init(gpRGB: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((gpRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((gpRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(gpRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
