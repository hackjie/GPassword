//
//  Point.swift
//  Point
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

class Point: CAShapeLayer {

    /// Draw direct
    public enum Direct: Int {
        case top = 1, rightTop, right, rightBottom, bottom, leftBottom, left, leftTop
    }

    /// Point selected
    var selected: Bool = false {
        didSet {
            drawAll()
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
    private lazy var innerNormal: Shape = {
        let rectWH = bounds.width * globalOptions.scale
        let rectXY = bounds.width * (1 - globalOptions.scale) * 0.5
        let rect =  CGRect(x: rectXY, y: rectXY, width: rectWH, height: rectWH)
        let inner = Shape(type: .innerNormal,
                            fillColor: globalOptions.innerNormalColor,
                            rect: rect,
                            stroke: globalOptions.isInnerStroke,
                            strokeColor: globalOptions.innerStrokeColor)
        return inner
    }()

    /// Contain draw infos of inner circle selected
    private lazy var innerSelected: Shape = {
        let rectWH = bounds.width * globalOptions.scale
        let rectXY = bounds.width * (1 - globalOptions.scale) * 0.5
        let rect =  CGRect(x: rectXY, y: rectXY, width: rectWH, height: rectWH)
        let inner = Shape(type: .innerSelected,
                            fillColor: globalOptions.innerSelectedColor,
                            rect: rect,
                            stroke: globalOptions.isInnerStroke,
                            strokeColor: globalOptions.innerStrokeColor)
        return inner
    }()

    /// Contain draw infos of inner circle normal
    private lazy var innerTriangle: Shape = {
        let rectWH = bounds.width * globalOptions.scale
        let rectXY = bounds.width * (1 - globalOptions.scale) * 0.5
        let rect =  CGRect(x: rectXY, y: rectXY, width: rectWH, height: rectWH)
        let inner = Shape(type: .triangle,
                            fillColor: globalOptions.triangleColor,
                            rect: rect,
                            stroke: globalOptions.isInnerStroke,
                            strokeColor: globalOptions.innerStrokeColor)
        return inner
    }()

    /// Contain draw infos of outer circle selected
    private lazy var outerSelected: Shape = {
        let sizeWH = bounds.width - 2 * globalOptions.pointLineWidth
        let originXY = globalOptions.pointLineWidth
        let rect = CGRect(x: originXY, y: originXY, width: sizeWH, height: sizeWH)
        let outer = Shape(type: .outerSelected,
                            fillColor: globalOptions.outerSelectedColor,
                            rect: rect,
                            stroke: globalOptions.isOuterStroke,
                            strokeColor: globalOptions.outerStrokeColor)
        return outer
    }()

    public enum DrawType: Int {
        case innerNormal, innerSelected, outerSelected, triangle
    }

    fileprivate struct Shape {
        let type: DrawType
        let fillColor: UIColor
        let rect: CGRect
        let stroke: Bool
        let strokeColor: UIColor
    }

    // MARK: - Lifecycle
    init(frame: CGRect) {
        super.init()
        self.frame = frame
        drawAll()
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func drawAll() {
        sublayers?.removeAll()
        if selected {
            drawShape(innerSelected)
            drawShape(outerSelected)
        } else {
            drawShape(innerNormal)
        }
    }

    fileprivate func drawShape(_ shape: Shape) {
        let path = UIBezierPath(ovalIn: shape.rect)
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = shape.fillColor.cgColor
        if shape.stroke {
            shapeLayer.strokeColor = shape.strokeColor.cgColor
        }
        shapeLayer.path = path.cgPath
        addSublayer(shapeLayer)
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
    fileprivate func drawTriangle(_ context: CGContext, _ shape: Shape) {
        if direct == nil {
            return
        }
        let trianglePathM = CGMutablePath()
        let width = globalOptions.triangleWidth
        let height = globalOptions.triangleHeight
        let topX = shape.rect.minX + shape.rect.width * 0.5
        let topY = shape.rect.minY + (shape.rect.width * 0.5 - height - globalOptions.offsetInnerCircleAndTriangle - shape.rect.height * 0.5)
        trianglePathM.move(to: CGPoint(x: topX, y: topY))
        let leftPointX = topX - width * 0.5
        let leftPointY = topY + height
        trianglePathM.addLine(to: CGPoint(x: leftPointX, y: leftPointY))
        let rightPointX = topX + width * 0.5
        trianglePathM.addLine(to: CGPoint(x: rightPointX, y: leftPointY))
        context.addPath(trianglePathM)
        shape.fillColor.set()
        context.fillPath()
    }
}
