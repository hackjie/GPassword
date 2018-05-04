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

let MaxPointsNum: Int = 9

import UIKit

/// Responsible for contain points and control touches
class Box: UIView {

    /// Points in box
    fileprivate var points = [Point]()

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

    // MARK: - draw
    override func draw(_ rect: CGRect) {
        if points.isEmpty { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.addRect(rect)
        points.forEach { (point) in
            context.addEllipse(in: point.frame)
        }
        context.clip()

        // manage line
        let linePath = CGMutablePath()
        globalOptions.connectLineColor.set()
        context.setLineCap(.round)
        context.setLineJoin(.round)
        context.setLineWidth(globalOptions.connectLineWidth)
        points.enumerated().forEach { (offset, element) in
            let directPoint = element.center
            if offset == 0 {
                linePath.move(to: directPoint)
            } else {
                linePath.addLine(to: directPoint)
            }
        }
        context.addPath(linePath)
        context.strokePath()

        // TODO: 画斜线因为矩形边框问题，斜线有空白导致画线显示比较短
    }

    // MARK: - touches
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
        // touches interrupted will call this method
        noMoreTouches()
    }

    // MARK: - helper
    func handleTouches(_ touches: Set<UITouch>) {
        guard !touches.isEmpty else { return }
        let location = touches.first!.location(in: self)
        guard let point = point(by: location), !points.contains(point) else { return }
        points.append(point)
        setDirect()
        point.selected = true
        setNeedsDisplay()
    }

    /// set direct for circle draw triangle
    func setDirect() {
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

    /// find point with location
    ///
    /// - Parameter location: CGPoint
    /// - Returns: Point
    func point(by location: CGPoint) -> Point? {
        for point in subviews where point is Point {
            if point.frame.contains(location) {
                return point as? Point
            }
        }
        return nil
    }

    func noMoreTouches() {
        // TODO: 没有触摸处理
    }

}
