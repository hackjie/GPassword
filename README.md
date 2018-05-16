# GPassword

![GPassword](https://github.com/hackjie/GPassword/blob/master/Resources/GPassword-logo.png)

[![](https://travis-ci.org/hackjie/GPassword.svg?branch=master)](https://travis-ci.org/hackjie/GPassword)
![](https://img.shields.io/badge/language-swift-orange.svg)
![](https://img.shields.io/badge/platform-ios-lightgrey.svg)
![](https://img.shields.io/badge/license-MIT-000000.svg)

中文版本请看[这里](https://github.com/hackjie/GPassword/wiki/GPassword)

Simple gesture password in swift

## Features

* Use delegate for gesture view to pass password
* Use CAShapeLayer、UIBezeierPath to draw for good performance
* Support define `3*3`、`4*4`... Matrix
* Support define many kinds of normal and selected style
* Use KeyChain to save informations

## Screenshots

<p align="center">
    <img src="https://github.com/hackjie/GPassword/blob/master/Resources/first.gif" width="30%" />
    <img src="https://github.com/hackjie/GPassword/blob/master/Resources/second.gif" width="30%" />
    <img src="https://github.com/hackjie/GPassword/blob/master/Resources/third.gif" width="30%" />
</p>

## Requirements

* iOS 8.0+
* Xcode 9.0+
* Swift 4.0+

## Install

CocoaPods

```swift
pod "GPassword"
```

or you can drag Source folder into your project.

## Usage

First custom UI style, here is what you need:

```swift
GPassword.config { (options) in
    options.connectLineStart = .border
    options.normalstyle = .innerFill
    options.isDrawTriangle = true
    options.matrixNum = 3
}
```

then you can use `Box.swift` or add it to a UIViewController

```swift
fileprivate lazy var passwordBox: Box = {
    let box = Box(frame: CGRect(x: 50, y: 200, width: GWidth - 2 * 50, height: 400))
    box.delegate = self
    return box
}()
```

then you need to achieve two delegate methods, you should write business logics in them, `sendTouchPoint` can send out complete password and `touchesEnded` can deal business logics according to type(setting/verify/modify) 

```swift
extension PasswordViewController: EventDelegate {
    func sendTouchPoint(with tag: String) {
        password += tag
        // get complete password
    }
    
    func touchesEnded() {
        // write business logics according to type
    }
}
```

more informations you can see `PasswordViewController.swift` in demo project, I write an example.

## License

GPassword is released under the MIT license. [See LICENSE](https://github.com/hackjie/GPassword/blob/master/LICENSE) for details



