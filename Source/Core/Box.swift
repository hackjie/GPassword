//
//  Box.swift
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

/// Responsible for contain points and control touches
open class Box: UIView {
    // MARK: - Properties

    /// Points selected in box
    fileprivate var points = [Point]()

    /// Current touching point
    var currentPoint: CGPoint?

    /// Connect line
    fileprivate var lineLayer = CAShapeLayer()

    public var delegate: EventDelegate?

    // MARK: - Lifecycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = globalOptions.boxBackgroundColor
        setupSubViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubViews() {
        (0..<(globalOptions.matrixNum * globalOptions.matrixNum)).forEach { (offset) in
            let space = globalOptions.pointSpace
            let pointWH = (frame.width - CGFloat(globalOptions.matrixNum - 1) * space) / CGFloat(globalOptions.matrixNum)
            // layout vertically
            let row = CGFloat(offset % globalOptions.matrixNum)
            let column = CGFloat(offset / globalOptions.matrixNum)
            let x = space * (row) + row * pointWH
            let y = space * (column) + column * pointWH
            let rect = CGRect(x: x, y: y, width: pointWH, height: pointWH)
            let point = Point(frame: rect)
            point.tag = offset
            layer.addSublayer(point)
        }
        layer.masksToBounds = true
    }

    /// Draw connect-lines
    private func drawLines() {
        if points.isEmpty { return }
        let linePath = UIBezierPath()
        linePath.lineCapStyle = .round
        linePath.lineJoinStyle = .round
        lineLayer.strokeColor = globalOptions.connectLineColor.cgColor
        lineLayer.fillColor = nil
        lineLayer.lineWidth = globalOptions.connectLineWidth

        points.enumerated().forEach { (offset, element) in
            let pointCenter = element.position
            if offset == 0 {
                linePath.move(to: pointCenter)
            } else {
                linePath.addLine(to: pointCenter)
            }
        }
        
        if let current = currentPoint {
            linePath.addLine(to: current)
        }
        lineLayer.path = linePath.cgPath
        if globalOptions.connectLineStart == .center {
            layer.addSublayer(lineLayer)
        } else {
            layer.insertSublayer(lineLayer, at: 0)
        }
    }

    // MARK: - Touches
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        noMoreTouches()
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        noMoreTouches()
    }

    // MARK: - Deal touches

    /// Handle touches, add to points, get draw angle
    ///
    /// - Parameter touches: Set<UITouch>
    private func handleTouches(_ touches: Set<UITouch>) {
        guard !touches.isEmpty else { return }
        currentPoint = touches.first!.location(in: self)
        let location = touches.first!.location(in: self)
        if let point = point(by: location), !points.contains(point) {
            points.append(point)
            calAngle()
            if hasOpenTrack() == nil || hasOpenTrack() == true {
                point.selected = true
            }
            // send touch point to delegate
            guard let delegate = self.delegate else { return }
            delegate.sendTouchPoint(with: "\(point.tag)")
        }
        if hasOpenTrack() == nil || hasOpenTrack() == true {
            drawLines()
        }
    }

    /// Calculate angle for circle draw triangle
    private func calAngle() {
        let count = points.count
        if count > 1 {
            let after = points[count - 1]
            let before = points[count - 2]

            let after_x = after.frame.minX
            let after_y = after.frame.minY
            let before_x = before.frame.minX
            let before_y = before.frame.minY
            
            let absX = fabsf(Float(before_x - after_x))
            let absY = fabsf(Float(before_y - after_y))
            let abxZ = sqrtf(pow(absX, 2) + pow(absY, 2))
            
            if before_x == after_x, before_y > after_y {
                before.angle = 0
            } else if before_x < after_x, before_y > after_y {
                before.angle = -CGFloat(asin(absX/abxZ))
            } else if before_x < after_x, before_y == after_y {
                before.angle = -CGFloat(Double.pi) / 2
            } else if before_x < after_x, before_y < after_y {
                before.angle = -(CGFloat(Double.pi) / 2) - CGFloat(asin(absY/abxZ))
            } else if before_x == after_x, before_y < after_y {
                before.angle = -CGFloat(Double.pi)
            } else if before_x > after_x, before_y < after_y {
                before.angle = -CGFloat(Double.pi) - CGFloat(asin(absX/abxZ))
            } else if before_x > after_x, before_y == after_y {
                before.angle = -CGFloat(Double.pi * 1.5)
            } else if before_x > after_x, before_y > after_y {
                before.angle = -CGFloat(Double.pi * 1.5) - CGFloat(asin(absY/abxZ))
            }
        }
    }

    /// Find point with location
    ///
    /// - Parameter location: CGPoint
    /// - Returns: Point
    private func point(by location: CGPoint) -> Point? {
        guard let sublayers = layer.sublayers else { return nil }
        for point in sublayers where point is Point {
            if point.frame.contains(location) {
                return point as? Point
            }
        }
        return nil
    }

    /// Deal no touches
    private func noMoreTouches() {
        currentPoint = points.last?.position
        points.forEach { (point) in
            point.selected = false
            point.angle = 9999
        }
        points.removeAll()
        lineLayer.removeFromSuperlayer()
        // tell delegate touch end
        guard let delegate = self.delegate else { return }
        delegate.touchesEnded()
    }
}
