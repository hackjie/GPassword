# GPassword

![GPassword](https://github.com/hackjie/GPassword/blob/master/Resources/GPassword-logo.png)

[![](https://travis-ci.org/hackjie/GPassword.svg?branch=master)](https://travis-ci.org/hackjie/GPassword)
![](https://img.shields.io/badge/language-swift-orange.svg)
![](https://img.shields.io/badge/platform-ios-lightgrey.svg)
![](https://img.shields.io/badge/license-MIT-000000.svg)

Simple gesture password in swift

中文版本参考[这里](https://github.com/hackjie/GPassword/wiki/GPassword)

## Features

* Use delegate for gesture view to pass password
* Use CAShapeLayer、UIBezeierPath to draw for good performance
* Support define `3*3`、`4*4`... Matrix
* Support define many kinds of normal and selected style
* Use KeyChain and UserDefaults to save informations

## Screenshots

<p align="center">
    <img src="https://github.com/hackjie/GPassword/blob/master/Resources/first.gif" width="30%" />
    <img src="https://github.com/hackjie/GPassword/blob/master/Resources/second.gif" width="30%" />
    <img src="https://github.com/hackjie/GPassword/blob/master/Resources/third.gif" width="30%" />
</p>

## Requirements

* CocoaPods / manual integration: historical requirements are iOS 8.0+, Xcode 9.0+, and Swift 4.0+.
* Swift Package Manager: Swift tools 5.0+; use Xcode 11+ for iOS app package integration. The library target uses Swift 4 language mode to match the existing source.
* The package retains the podspec's iOS 8.0 deployment declaration. This does not certify iOS 8 support with modern SDKs. Current Xcode/SDK compatibility and the oldest working iOS version still require validation.
* This is a UIKit library for iOS. A host-only `swift build` on macOS or Linux is not an iOS build.

## Install

### CocoaPods

```ruby
pod "GPassword"
```

### Swift Package Manager

In Xcode, choose **File > Add Package Dependencies** (called **Add Packages** or **Swift Packages > Add Package Dependency** in some versions), enter:

```text
https://github.com/hackjie/GPassword.git
```

Select a revision or branch that contains `Package.swift`, then add the **GPassword** library product to your iOS app target. The existing `1.0.9` tag does not contain a package manifest; it cannot be used for SwiftPM installation. After a new semantic version tag containing the manifest has been published and validated, prefer a version-based dependency on that release.

For local validation before publishing, add the repository folder as a local package to a separate iOS app. Do not add GPassword through CocoaPods, SwiftPM, or copied source more than once in the same app target.

The package includes only `Source/**/*.swift`. The demo app, its storyboards and localized strings, and the README images are not library resources. No external package dependency is required; KeychainSwift is already included in `Source/Store`.

### Manual integration

You can still drag the `Source` folder into your project.

### Validating SwiftPM support

On a Mac with Xcode and an iOS SDK, run these commands from the repository root:

```sh
xcodebuild -version
xcrun swift --version
xcrun swift package dump-package
xcrun swift package describe
xcodebuild -list
```

Confirm that the manifest declares one `GPassword` library target, no package dependencies, and all nine Swift files under `Source`. Manifest parsing and package description do not compile the library. Select the library scheme shown by `xcodebuild -list` (normally `GPassword`), then build for iOS Simulator and iOS devices:

```sh
xcodebuild -scheme GPassword -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO build
xcodebuild -scheme GPassword -destination 'generic/platform=iOS' CODE_SIGNING_ALLOWED=NO build
```

Next, build and run a separate iOS app that imports `GPassword`, configures its options, creates a `Box`, and implements `GPasswordEventDelegate`. Check gesture callbacks, drawing, and password save/read/delete on a device. When switching an existing app from CocoaPods to SwiftPM, keep its bundle identifier, signing entitlements, and storage keys unchanged and verify that previously stored data can still be read. Also validate an existing CocoaPods app independently; adding a manifest does not itself verify either installation method.

This change does not include a verified Xcode build or runtime test. Swift 4 language mode, older Security APIs, and the iOS 8.0 deployment declaration may need follow-up work for the selected toolchain. Record the actual Xcode/Swift/SDK versions and build results before publishing a release. There is currently no automated test target.

## Usage

For CocoaPods or SwiftPM, import the `GPassword` module as shown below. When copying source files directly into your app, omit `import GPassword` and call the top-level functions without the `GPassword.` module prefix.

First custom UI style, here is what you need:

```swift
import UIKit
import GPassword

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
extension PasswordViewController: GPasswordEventDelegate {
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



