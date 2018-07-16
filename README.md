# GPassword

![GPassword](https://github.com/hackjie/GPassword/blob/master/Resources/GPassword-logo.png)

[![](https://travis-ci.org/hackjie/GPassword.svg?branch=master)](https://travis-ci.org/hackjie/GPassword)
![](https://img.shields.io/badge/language-swift-orange.svg)
![](https://img.shields.io/badge/platform-ios-lightgrey.svg)
![](https://img.shields.io/badge/license-MIT-000000.svg)

English info please see [here](https://github.com/hackjie/GPassword/wiki/GPassword)

GPassword 是一个简单、高效、易用的`手势密码库`，基于 CAShapeLayer 和 UIBezeierPath。

## 重写手势密码(九宫格)的缘由

1. Swift 版现在 Github 上都比较难用，依据这些难用的改造的也不怎么好用～
2. 功能不大，但是涉及的东西挺有意思，我重写复习了下`三角函数和反三角函数`
3. 原有库使用重写 drawRect 在绘制时会造成内存暴涨
4. 原有库视图层级复杂造成额外不必要的代码逻辑
5. 原有库代码耦合严重、难于扩展
6. 封装手势密码`私有库`时，最后暴露出来的不应该是一个控制器，而应该是视图，要不然做界面定制将会很难做

## 特性

* 使用代理将手势密码图绘制完成的密码传出
* 使用 CAShapeLayer 和 UIBezeierPath，拥有更好的性能
* 支持定义 `3*3`、`4*4`...的矩阵
* 支持多种正常和选中的样式
* 使用 KeyChain 和 UserDefaults 来存储相关信息

## 部分截图展示

<p align="center">
    <img src="https://github.com/hackjie/GPassword/blob/master/Resources/first.gif" width="30%" />
    <img src="https://github.com/hackjie/GPassword/blob/master/Resources/second.gif" width="30%" />
    <img src="https://github.com/hackjie/GPassword/blob/master/Resources/third.gif" width="30%" />
</p>

## 要求

* iOS 8.0+
* Xcode 9.0+
* Swift 4.0+

## 安装

CocoaPods

```swift
pod "GPassword"
```

或者直接拖拽 `Source` 文件夹进入你的项目。

## 使用

定义统一的样式，你可以调用：

```swift
GPassword.config { (options) in
    options.connectLineStart = .border
    options.normalstyle = .innerFill
    options.isDrawTriangle = true
    options.matrixNum = 3
}
```

然后可以直接用这个文件 `Box.swift` 直接作为`手势密码`视图或者将它添加到`控制器`上使用

```swift
fileprivate lazy var passwordBox: Box = {
    let box = Box(frame: CGRect(x: 50, y: 200, width: GWidth - 2 * 50, height: 400))
    box.delegate = self
    return box
}()
```

然后需要做的就是实现两个代理方法，具体的业务逻辑也应该在里面实现：

1. `sendTouchPoint` 可以从内部发出完整的手势密码
2. `touchesEnded` 根据类型(设置/确认/修改)处理具体的业务逻辑

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

开发人可以根据自己的业务逻辑实现具体的细节，在 demo 里我已经写了一个简单的例子可以直接使用参考 `PasswordViewController.swift`，根据自己的情况进行调整。

## License

GPassword is released under the MIT license. [See LICENSE](https://github.com/hackjie/GPassword/blob/master/LICENSE) for details



