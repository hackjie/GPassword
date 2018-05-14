//
//  GPassword.swift
//  GPassword
//
//  Created by Jie Li on 26/4/18.
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

/// LockOptions is options for user to adjust something about UI.
/// call GPassword.config to config global
public class LockOptions {
    
    /// Num for Matrix. eg: 3 is 3*3; 4  is 4*4
    /// you need to adjust pointSpace to fit this matrix
    public var matrixNum: Int = 3

    /// Lock normal style
    public var normalstyle: NormalStyle = .outerStroke

    /// Box background color
    public var boxBackgroundColor: UIColor = .white

    /// Connect line color
    public var connectLineColor: UIColor = UIColor(gpRGB: 0x6EBF60)

    /// Connect line width
    public var connectLineWidth: CGFloat = 4.0

    /// Connect line start position
    public var connectLineStart: LineStart = .border

    /// Point context line width
    public var pointLineWidth: CGFloat = 1.0

    /// Point background color
    public var pointBackgroundColor: UIColor = .white

    /// Point inner circle selected color
    public var innerSelectedColor: UIColor = UIColor(gpRGB: 0x8ABF82)

    /// Point inner circle normal color
    public var innerNormalColor: UIColor = UIColor(gpRGB: 0xE2E3F2)

    /// Point outer circle selected color
    public var outerSelectedColor: UIColor = .white

    /// Point inner circle scale of Point
    public var scale: CGFloat = 0.3

    /// Point inner circle whether draw stroke, width according to pointLineWidth
    public var isInnerStroke: Bool = false

    /// Point outer circle whether draw stroke, width according to pointLineWidth
    public var isOuterStroke: Bool = true

    /// Point inner circle draw stroke color
    public var innerStrokeColor: UIColor = UIColor(gpRGB: 0x8ABF82)

    /// Point outer circle draw stroke color
    public var outerStrokeColor: UIColor = UIColor(gpRGB: 0x8ABF82)

    /// Space between points
    public var pointSpace: CGFloat = 30.0

    /// Point inner circle whether draw triangle
    public var isDrawTriangle: Bool = false

    /// Triangle background color
    public var triangleColor: UIColor = UIColor(gpRGB: 0x8ABF82)

    /// Triangle width
    public var triangleWidth: CGFloat = 10

    /// Triangle height
    public var triangleHeight: CGFloat = 7

    /// Offset between inner circle and triangle
    public var offsetInnerCircleAndTriangle: CGFloat = 4

    /// Enum about draw connect line start from center or border
    public enum LineStart {
        case center, border
    }

    /// Enum about Point normal style
    public enum NormalStyle {
        case innerFill, outerStroke
    }
    
    /// Key for saving whether show points selected
    public var trackKey = "track_key"
    
    /// Used to verify and modify
    public var maxErrorNum: Int = 5
}
