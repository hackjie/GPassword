//
//  PasswordViewController.swift
//  GPassword
//
//  Created by Jie Li on 10/5/18.
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

let lessConnectPointsNum: Int = 3
let passwordKey = "gesture_password"
let errorPasswordKey = "error_gesture_password"

enum GType {
    case set
    case verify
    case modify
}

class WarnLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showNormal(with message: String) {
        text = message
        textColor = UIColor.black
    }

    func showWarn(with message: String) {
        text = message
        textColor = UIColor(gpRGB: 0xC94349)
        layer.shake()
    }
}

class PasswordViewController: UIViewController {

    // MARK: - Properies
    fileprivate lazy var passwordBox: Box = {
        let box = Box(frame: CGRect(x: 50, y: 200, width: GWidth - 2 * 50, height: 400))
        box.delegate = self
        return box
    }()

    fileprivate lazy var warnLabel: WarnLabel = {
        let label = WarnLabel(frame: CGRect(x: 50, y: 140, width: GWidth - 2 * 50, height: 20))
        label.text = String.gp_localized("normal_title")
        return label
    }()

    fileprivate lazy var LoginBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: (GWidth - 200)/2, y: GHeight - 60, width: 200, height: 20))
        button.setTitle(String.gp_localized("forget_password_title"), for: .normal)
        button.setTitleColor(UIColor(gpRGB: 0x1D80FC), for: .normal)
        return button
    }()

    var password: String = ""
    var firstPassword: String = ""
    var secondPassword: String = ""
    var canModify: Bool = false
    var type: GType? {
        didSet {
            if type == .set {
                warnLabel.text = String.gp_localized("setting_password_title")
            } else if type == .verify {
                warnLabel.text = String.gp_localized("normal_title")
            } else {
                warnLabel.text = String.gp_localized("input_origin_password")
            }
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - layout
    func setupSubviews() {
        view.backgroundColor = .white
        title = String.gp_localized("gesture_password")
        GPassword.config { (options) in
            options.connectLineStart = .border
            options.normalstyle = .outerStroke
            options.isDrawTriangle = false
            options.connectLineWidth = 4
            options.matrixNum = 3
        }

        view.addSubview(passwordBox)
        view.addSubview(warnLabel)
        view.addSubview(LoginBtn)

        print(GPassword.getPassword(with: passwordKey) ?? "")
    }
}

extension PasswordViewController: EventDelegate {
    func sendTouchPoint(with tag: String) {
        print(tag)
        password += tag
    }

    func touchesEnded() {
        print("gesture end")

        if password.count < lessConnectPointsNum {
            warnLabel.showWarn(with: String.gp_localized("less_connect_point_num"))
            warnLabel.textColor = UIColor(gpRGB: 0xC94349)
        } else {
            if type == .set {
                setPassword()
            } else if type == .modify {
                let savePassword = GPassword.getPassword(with: passwordKey)
                if let pass = savePassword {
                    if canModify {
                        setPassword()
                    } else {
                        if password == pass {
                            warnLabel.showNormal(with: String.gp_localized("setting_password_title"))
                            canModify = true
                        } else {
                            verifyPasswordError()
                        }
                    }
                }
            } else {
                let savePassword = GPassword.getPassword(with: passwordKey) ?? ""
                if password == savePassword {
                    navigationController?.popViewController(animated: true)
                } else {
                    verifyPasswordError()
                }
            }
        }

        password = ""
    }
}

extension PasswordViewController {
    func setPassword() {
        if firstPassword.isEmpty {
            firstPassword = password
            warnLabel.showNormal(with: String.gp_localized("once_input_confirm"))
        } else {
            secondPassword = password
            if firstPassword == secondPassword {
                GPassword.save(password: firstPassword, with: passwordKey)
                navigationController?.popViewController(animated: true)
            } else {
                warnLabel.showWarn(with: String.gp_localized("two_input_different"))
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self.warnLabel.showNormal(with: String.gp_localized("setting_password_title"))
                }
                firstPassword = ""
                secondPassword = ""
            }
        }
    }

    func verifyPasswordError() {
        GPassword.increaseErrorNum(with: errorPasswordKey)
        let errorNum = globalOptions.maxErrorNum - GPassword.getErrorNum(with: errorPasswordKey)!
        if errorNum == 0 {
            // do action about forgetting password
            warnLabel.showWarn(with: String.gp_localized("forget_password_title"))
        } else {
            var errorTitle = String.gp_localized("password_input_error")
                + "\(errorNum)"
            if PasswordViewController.getCurrentLanguage() == "en" {
                errorTitle += "times"
            } else {
                errorTitle += "次"
            }
            warnLabel.showWarn(with: errorTitle)
        }
    }

    static func getCurrentLanguage() -> String {
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        switch String(describing: preferredLang) {
        case "en-US", "en-CN":
            return "en"
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans":
            return "cn"
        default:
            return "en"
        }
    }
}

