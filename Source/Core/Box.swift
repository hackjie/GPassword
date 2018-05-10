//
//  Box.swift
//  Box
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

fileprivate let MaxPointsNum: Int = 9

import UIKit

/// Responsible for contain points and control touches
class Box: UIView {
    // MARK: - Properties

    /// Points selected in box
    fileprivate var points = [Point]()

    /// Current touching point
    var currentPoint: CGPoint?

    /// Connect line
    fileprivate var lineLayer = CAShapeLayer()

    var delegate: EventDelegate?

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = globalOptions.boxBackgroundColor
        setupSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubViews() {
        (0..<MaxPointsNum).forEach { (offset) in
            let space = globalOptions.pointSpace
            let pointWH = (frame.width - 4 * space)/3.0
            // layout vertically
            let row = CGFloat(offset % 3)
            let column = CGFloat(offset / 3)
            let x = space * (row + 1) + row * pointWH
            let y = space * (column + 1) + column * pointWH
            let rect = CGRect(x: x, y: y, width: pointWH, height: pointWH)
            let point = Point(frame: rect)
            layer.addSublayer(point)
        }
        layer.masksToBounds = true
    }

    /// Draw selected point and connect-line
    private func drawSelectedShapesAndLines() {
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
        linePath.addLine(to: currentPoint!)
        lineLayer.path = linePath.cgPath
        if globalOptions.connectLineStart == .center {
            layer.addSublayer(lineLayer)
        } else {
            layer.insertSublayer(lineLayer, at: 0)
        }
    }

    // MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        noMoreTouches()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        noMoreTouches()
    }

    // MARK: - Deal touches

    /// Handle touches, add to points, get draw direct
    ///
    /// - Parameter touches: Set<UITouch>
    private func handleTouches(_ touches: Set<UITouch>) {
        guard !touches.isEmpty else { return }
        currentPoint = touches.first!.location(in: self)
        let location = touches.first!.location(in: self)
        if let point = point(by: location), !points.contains(point) {
            points.append(point)
            setDirect()
            point.selected = true
        }
        drawSelectedShapesAndLines()
    }

    /// Set direct for circle draw triangle
    private func setDirect() {
        let count = points.count
        if count > 1 {
            let after = points[count - 1]
            let before = points[count - 2]

            let after_x = after.frame.minX
            let after_y = after.frame.minY
            let before_x = before.frame.minX
            let before_y = before.frame.minY
            if before_x == after_x, before_y > after_y {
                before.direct = .top
            } else if before_x < after_x, before_y > after_y {
                before.direct = .rightTop
            } else if before_x < after_x, before_y == after_y {
                before.direct = .right
            } else if before_x < after_x, before_y < after_y {
                before.direct = .rightBottom
            } else if before_x == after_x, before_y < after_y {
                before.direct = .bottom
            } else if before_x > after_x, before_y < after_y {
                before.direct = .leftBottom
            } else if before_x > after_x, before_y == after_y {
                before.direct = .left
            } else if before_x > after_x, before_y > after_y {
                before.direct = .leftTop
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
            point.direct = nil
        }
        points.removeAll()
        lineLayer.removeFromSuperlayer()
    }
}
