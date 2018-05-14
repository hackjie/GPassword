# GPassword

![GPassword](https://github.com/hackjie/GPassword/blob/master/Resources/GPassword.png)

![Swift](https://img.shields.io/badge/language-swift-orange.svg)

Simple gesture password in swift

## Features

* Use delegate for gesture view to pass password
* Use CAShapeLayer、UIBezeierPath to draw for good performance
* Support define `3*3`、`4*4`... Matrix
* Support define many kinds of normal and selected style
* Use KeyChain to save informations

## Install

CocoaPods

```swift
pod "GPassword"
```

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

then you need to achieve two delegate methods

```swift
extension PasswordViewController: EventDelegate {
    func sendTouchPoint(with tag: String) {
        print(tag)
        password += tag
    }
    
    func touchesEnded() {
    
    }
}
```

more you can see demo

## License

GPassword is released under the MIT license. [See LICENSE](https://github.com/hackjie/GPassword/blob/master/LICENSE) for details



