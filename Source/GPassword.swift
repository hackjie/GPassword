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

import Foundation

public let globalOptions = LockManager.default.options

public typealias ConfigOptionsCompletion = (_ options: LockOptions) -> Void

/// Config lock view properties. eg: color title...
///
/// - Parameter config: ConfigOptionsCompletion
public func config(_ config: ConfigOptionsCompletion) {
    config(globalOptions)
}

// MARK: - Save get remove password

/// Save Password
///
/// - Parameters:
///   - password: String
///   - key: String
public func save(password: String, with key: String) {
    LockManager.default.save(string: password, with: key)
}

/// Remove Password
///
/// - Parameter key: String
public func removePassword(with key: String) {
    LockManager.default.removeItem(with: key)
}

/// Get Password
///
/// - Parameter key: String
/// - Returns: String Optional
public func getPassword(with key: String) -> String? {
    return LockManager.default.getStringItem(with: key)
}

// MARK: - Control gesture open close

/// Whether open gesture password
///
/// - Parameter key: String
/// - Returns: Bool Optional
public func hasOpenGesture(with key: String) -> Bool? {
    return LockManager.default.getBoolItem(with: key)
}

/// Open gesture password
///
/// - Parameter key: String
public func openGesture(with key: String) {
    LockManager.default.save(bool: true, with: key)
}

/// Close gesture password
///
/// - Parameter key: String
public func closeGesture(with key: String) {
    LockManager.default.save(bool: false, with: key)
}

// MARK: - Control show selected-track or not

/// Whether show points those had been selected
///
/// - Returns: Bool Optional
public func hasOpenTrack() -> Bool? {
    return LockManager.default.getBoolItem(with: globalOptions.trackKey)
}

/// Show points selected
public func openTrack() {
    LockManager.default.save(bool: true, with: globalOptions.trackKey)
}

/// Hide points selected
public func closeTrack() {
    LockManager.default.save(bool: false, with: globalOptions.trackKey)
}

// MARK: - Max error num

/// Increase error num
///
/// - Parameter key: String
public func increaseErrorNum(with key: String) {
    var num = 0
    
    if let hasNum = getErrorNum(with: key), hasNum < globalOptions.maxErrorNum {
        num = hasNum + 1
    } else {
        num = globalOptions.maxErrorNum
    }
    LockManager.default.save(string: String(num), with: key)
}

/// Get error num
///
/// - Parameter key: String
/// - Returns: Int Optional
public func getErrorNum(with key: String) -> Int? {
    return Int(LockManager.default.getStringItem(with: key) ?? "0")
}

/// Remove error record
///
/// - Parameter key: String
public func removeErrorNum(with key: String) {
    LockManager.default.removeItem(with: key)
}
