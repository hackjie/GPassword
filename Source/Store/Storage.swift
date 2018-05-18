//
//  Storagable.swift
//  GPassword
//
//  Created by Jie Li on 8/5/18.
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

// MARK: - Protocol for set/get/remove value
protocol Storage {
    func gp_set(_ value: String, with key: String)
    func gp_get(with key: String) -> String?
    func gp_setBool(_ value: Bool, with key: String)
    func gp_getBool(with key: String) -> Bool?
    func gp_remove(with key: String)
}


// MARK: - UserDefaults
extension UserDefaults: Storage {
    func gp_set(_ value: String, with key: String) {
        self.setValue(value, forKey: key)
        self.synchronize()
    }

    func gp_get(with key: String) -> String? {
        return self.string(forKey: key)
    }

    func gp_setBool(_ value: Bool, with key: String) {
        self.setValue(value, forKey: key)
        self.synchronize()
    }

    func gp_getBool(with key: String) -> Bool? {
        return self.bool(forKey: key)
    }

    func gp_remove(with key: String) {
        self.removeObject(forKey: key)
    }
}

// MARK: - KeyChain
extension KeychainSwift: Storage {
    func gp_set(_ value: String, with key: String) {
        self.set(value, forKey: key)
    }

    func gp_get(with key: String) -> String? {
        return self.get(key)
    }

    func gp_setBool(_ value: Bool, with key: String) {
        self.set(value, forKey: key)
    }

    func gp_getBool(with key: String) -> Bool? {
        return self.getBool(key)
    }

    func gp_remove(with key: String) {
        self.delete(key)
    }
}
