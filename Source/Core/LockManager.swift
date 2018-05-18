//
//  LockManager.swift
//  GPassword
//
//  Created by Jie Li on 11/5/18.
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

/// Responsible for manage gesture password
class LockManager {
    /// Singleton
    static let `default`: LockManager = {
        return LockManager()
    }()

    private init() {}

    /// Options for gesture password
    var options = LockOptions()

    /// Storage for manage gesture password
    var storage: Storage = KeychainSwift()

    /// Save String item with key
    ///
    /// - Parameters:
    ///   - password: String
    ///   - key: String
    func save(string item: String, with key: String) {
        storage.gp_set(item, with: key)
    }

    /// Get String item with key
    ///
    /// - Parameter key: String
    /// - Returns: String Optional
    func getStringItem(with key: String) -> String? {
        return storage.gp_get(with: key)
    }

    /// Save Bool item with key
    ///
    /// - Parameters:
    ///   - item: Bool
    ///   - key: String
    func save(bool item: Bool, with key: String) {
        storage.gp_setBool(item, with: key)
    }

    /// Get Bool item with key
    ///
    /// - Parameter key: String
    /// - Returns: Bool Optional
    func getBoolItem(with key: String) -> Bool? {
        return storage.gp_getBool(with: key)
    }

    /// Remove item with key
    ///
    /// - Parameter key: String
    func removeItem(with key: String) {
        storage.gp_remove(with: key)
    }
}

