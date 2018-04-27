//
//  GPassword.swift
//  GPassword
//
//  Created by Jie Li on 27/4/18.
//
//  Copyright (c) 2018 Jie Li <codelijie@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import CoreGraphics

/// Responsible for drawing a single point
class Point: UIView {

    /// Draw direct
    public enum Direct: Int {
        case top = 1, rightTop, right, rightBottom, bottom, leftBottom, left, leftTop
    }

    /// Contain infos to draw
    struct DrawBag {
        let color: UIColor
        let rect: CGRect
    }

    /// Selected state call setNeedsDisplay
    public var selected: Bool = true {
        willSet {
            setNeedsDisplay()
        }
    }

    /// Contain draw infos of inner circle selected
    private lazy var innerSelected: DrawBag = {
        let rectWH = bounds.width * globalOptions.scale
        let rectXY = bounds.width * (1 - globalOptions.scale) * 0.5
        let rect =  CGRect(x: rectXY, y: rectXY, width: rectWH, height: rectWH)
        let inner = DrawBag(color: globalOptions.innerSelectedColor,
                            rect: rect)
        return inner
    }()

    /// Contain draw infos of inner circle normal
    private lazy var innerNormal: DrawBag = {
        let rectWH = bounds.width * globalOptions.scale
        let rectXY = bounds.width * (1 - globalOptions.scale) * 0.5
        let rect =  CGRect(x: rectXY, y: rectXY, width: rectWH, height: rectWH)
        let inner = DrawBag(color: globalOptions.innerNormalColor,
                            rect: rect)
        return inner
    }()

    /// Contain draw infos of outer circle selected
    private lazy var outerSelected: DrawBag = {
        let sizeWH = bounds.width - globalOptions.pointLineWidth
        let originXY = globalOptions.pointLineWidth * 0.5
        let rect = CGRect(x: originXY, y: originXY, width: sizeWH, height: sizeWH)
        let outer = DrawBag(color: globalOptions.outerSelectedColor,
                            rect: rect)
        return outer
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = globalOptions.pointBackgroundColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Override draw(_ rect:)
    ///
    /// - Parameter rect: CGRect
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            // TODO: 旋转

            // context options
            context.setLineWidth(LockManager.default.lockOptions.pointLineWidth)
            if selected {
                draw(context, innerSelected)
                draw(context, outerSelected)
            } else {
                draw(context, innerNormal)
            }
        }
    }

    /// Draw circle accoding to DrawBag
    ///
    /// - Parameters:
    ///   - context: CGContext
    ///   - circle: DrawBag
    private func draw(_ context: CGContext, _ circle: DrawBag) {
        let path = CGMutablePath()
        path.addEllipse(in: circle.rect)
        context.addPath(path)
        circle.color.set()
        context.fillPath()
    }
}
