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

    public enum DrawType: Int {
        case innerNormal, innerSelected, outerSelected, triangle
    }

    /// Contain infos to draw
    struct DrawBag {
        let type: DrawType
        let fillColor: UIColor
        let rect: CGRect
        let stroke: Bool
        let strokeColor: UIColor
    }

    /// Selected state call setNeedsDisplay
    var selected: Bool = false {
        willSet {
            setNeedsDisplay()
        }
    }

    /// Angle used to draw triangle when isDrawTriangle is true
    fileprivate var angle: CGFloat?

    /// Draw direct
    var direct: Direct? {
        willSet {
            if let value = newValue {
                angle = CGFloat(Double.pi / 4) * CGFloat(value.rawValue - 1)
                setNeedsDisplay()
            }
        }
    }

    /// Contain draw infos of inner circle normal
    private lazy var innerNormal: DrawBag = {
        let rectWH = bounds.width * globalOptions.scale
        let rectXY = bounds.width * (1 - globalOptions.scale) * 0.5
        let rect =  CGRect(x: rectXY, y: rectXY, width: rectWH, height: rectWH)
        let inner = DrawBag(type: .innerNormal,
                            fillColor: globalOptions.innerNormalColor,
                            rect: rect,
                            stroke: globalOptions.isInnerStroke,
                            strokeColor: globalOptions.innerStrokeColor)
        return inner
    }()

    /// Contain draw infos of inner circle selected
    private lazy var innerSelected: DrawBag = {
        let rectWH = bounds.width * globalOptions.scale
        let rectXY = bounds.width * (1 - globalOptions.scale) * 0.5
        let rect =  CGRect(x: rectXY, y: rectXY, width: rectWH, height: rectWH)
        let inner = DrawBag(type: .innerSelected,
                            fillColor: globalOptions.innerSelectedColor,
                            rect: rect,
                            stroke: globalOptions.isInnerStroke,
                            strokeColor: globalOptions.innerStrokeColor)
        return inner
    }()

    /// Contain draw infos of inner circle normal
    private lazy var innerTriangle: DrawBag = {
        let rectWH = bounds.width * globalOptions.scale
        let rectXY = bounds.width * (1 - globalOptions.scale) * 0.5
        let rect =  CGRect(x: rectXY, y: rectXY, width: rectWH, height: rectWH)
        let inner = DrawBag(type: .triangle,
                            fillColor: globalOptions.triangleColor,
                            rect: rect,
                            stroke: globalOptions.isInnerStroke,
                            strokeColor: globalOptions.innerStrokeColor)
        return inner
    }()

    /// Contain draw infos of outer circle selected
    private lazy var outerSelected: DrawBag = {
        let sizeWH = bounds.width - 2 * globalOptions.pointLineWidth
        let originXY = globalOptions.pointLineWidth
        let rect = CGRect(x: originXY, y: originXY, width: sizeWH, height: sizeWH)
        let outer = DrawBag(type: .outerSelected,
                            fillColor: globalOptions.outerSelectedColor,
                            rect: rect,
                            stroke: globalOptions.isOuterStroke,
                            strokeColor: globalOptions.outerStrokeColor)
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
        guard let context = UIGraphicsGetCurrentContext() else { return }
        transform(context, rect: rect)
        // context options
        context.setLineWidth(globalOptions.pointLineWidth)
        if selected {
            draw(context, innerSelected)
            draw(context, outerSelected)
            if globalOptions.isDrawTriangle {
                drawTriangle(context, innerTriangle)
            }
        } else {
            draw(context, innerNormal)
        }
    }

    /// Draw circle accoding to DrawBag
    ///
    /// - Parameters:
    ///   - context: CGContext
    ///   - circle: DrawBag
    private func draw(_ context: CGContext, _ circle: DrawBag) {
        context.addEllipse(in: circle.rect)
        circle.fillColor.set()
        context.fillPath()
        if circle.stroke {
            context.setStrokeColor(circle.strokeColor.cgColor)
            context.strokeEllipse(in: circle.rect)
        }
    }

    /// transform context to draw triangle then transform back
    ///
    /// - Parameters:
    ///   - context: CGContext
    ///   - rect: CGRect
    func transform(_ context: CGContext, rect: CGRect) {
        let translateXY = rect.width * 0.5
        context.translateBy(x: translateXY, y: translateXY)
        context.rotate(by: angle ?? 0)
        context.translateBy(x: -translateXY, y: -translateXY)
    }

    /// draw triangle
    ///
    /// - Parameters:
    ///   - context: CGContext
    ///   - circle: DrawBag
    func drawTriangle(_ context: CGContext, _ circle: DrawBag) {
        if direct == nil {
            return
        }
        let trianglePathM = CGMutablePath()
        let width = globalOptions.triangleWidth
        let height = globalOptions.triangleHeight
        let topX = circle.rect.minX + circle.rect.width * 0.5
        let topY = circle.rect.minY + (circle.rect.width * 0.5 - height - globalOptions.offsetInnerCircleAndTriangle - circle.rect.height * 0.5)
        trianglePathM.move(to: CGPoint(x: topX, y: topY))
        let leftPointX = topX - width * 0.5
        let leftPointY = topY + height
        trianglePathM.addLine(to: CGPoint(x: leftPointX, y: leftPointY))
        let rightPointX = topX + width * 0.5
        trianglePathM.addLine(to: CGPoint(x: rightPointX, y: leftPointY))
        context.addPath(trianglePathM)
        circle.fillColor.set()
        context.fillPath()
    }
}
