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
public func save(password: String) {
    LockManager.default.save(string: password, with: PASSWORD_KEY + globalOptions.keySuffix)
}

/// Remove Password
public func removePassword() {
    LockManager.default.removeItem(with: PASSWORD_KEY + globalOptions.keySuffix)
}

/// Get Password
///
/// - Returns: String Optional
public func getPassword() -> String? {
    return LockManager.default.getStringItem(with: PASSWORD_KEY + globalOptions.keySuffix)
}

// MARK: - Control gesture open close

/// Whether open gesture password
///
/// - Returns: Bool Optional
public func hasOpenGesture() -> Bool? {
    return LockManager.default.getBoolItem(with: CONTROL_KEY + globalOptions.keySuffix)
}

/// Open gesture password
public func openGesture() {
    LockManager.default.save(bool: true, with: CONTROL_KEY + globalOptions.keySuffix)
}

/// Close gesture password
public func closeGesture() {
    LockManager.default.save(bool: false, with: CONTROL_KEY + globalOptions.keySuffix)
}

// MARK: - Control show selected-track or not

/// Whether show points those had been selected
///
/// - Returns: Bool Optional
public func hasOpenTrack() -> Bool? {
    return LockManager.default.getBoolItem(with: CONTROL_TRACK_KEY + globalOptions.keySuffix)
}

/// Show points selected
public func openTrack() {
    LockManager.default.save(bool: true, with: CONTROL_TRACK_KEY + globalOptions.keySuffix)
}

/// Hide points selected
public func closeTrack() {
    LockManager.default.save(bool: false, with: CONTROL_TRACK_KEY + globalOptions.keySuffix)
}

// MARK: - Max error num

/// Increase error num
public func increaseErrorNum() {
    var num = 0
    let key = ERROR_NUM_KEY + globalOptions.keySuffix
    if let hasNum = getErrorNum(), hasNum < globalOptions.maxErrorNum {
        num = hasNum + 1
    } else {
        num = globalOptions.maxErrorNum
    }
    LockManager.default.save(string: String(num), with: key)
}

/// Get error num
///
/// - Returns: Int Optional
public func getErrorNum() -> Int? {
    let key = ERROR_NUM_KEY + globalOptions.keySuffix
    return Int(LockManager.default.getStringItem(with: key) ?? "0")
}

/// Remove error record
public func removeErrorNum() {
    let key = ERROR_NUM_KEY + globalOptions.keySuffix
    LockManager.default.removeItem(with: key)
}
