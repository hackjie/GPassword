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

    /// Box background color
    public var boxBackgroundColor: UIColor = .white

    /// Line connect points
    public var connectionLineColor = UIColor.black

    /// Point context line width
    public var pointLineWidth: CGFloat = 1.0

    /// Point background color
    public var pointBackgroundColor: UIColor = .white

    /// Point inner circle selected color
    public var innerSelectedColor: UIColor = .blue

    /// Point inner circle normal color
    public var innerNormalColor: UIColor = .lightGray

    /// Point outer circle selected color
    public var outerSelectedColor: UIColor = UIColor(gpRGB: 0xF6D05F, alpha: 0.5)

    /// Point inner circle scale of Point
    public var scale: CGFloat = 0.3

    /// Point inner circle whether draw stroke, width according to pointLineWidth
    public var isInnerStroke: Bool = false

    /// Point outer circle whether draw stroke, width according to pointLineWidth
    public var isOuterStroke: Bool = false

    /// Point inner circle draw stroke color
    public var innerStrokeColor: UIColor = .red

    /// Point outer circle draw stroke color
    public var outerStrokeColor: UIColor = .red

    /// Space between points
    public var pointSpace: CGFloat = 24.0
}
