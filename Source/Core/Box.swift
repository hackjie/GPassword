//
//  Box.swift
//  GPassword
//
//  Created by leoli on 2018/4/28.
//  Copyright © 2018年 leoli. All rights reserved.
//

let MaxPointsNum: Int = 9

import UIKit

/// Responsible for contain points and control touches
class Box: UIView {

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = globalOptions.boxBackgroundColor
        (0..<MaxPointsNum).forEach { (_) in
            let point = Point()
            addSubview(point)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let space = globalOptions.pointSpace
        let pointWH = (frame.width - 4 * space)/3.0
        subviews.enumerated().forEach { (offset, element) in
            // layout vertically
            let row = CGFloat(offset % 3)
            let column = CGFloat(offset / 3)
            let x = space * (row + 1) + row * pointWH
            let y = space * (column + 1) + column * pointWH
            let rect = CGRect(x: x, y: y, width: pointWH, height: pointWH)
            element.tag = offset
            element.frame = rect
        }
    }

}
