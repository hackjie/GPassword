//
//  PasswordViewController.swift
//  GPassword
//
//  Created by leoli on 2018/5/10.
//  Copyright © 2018年 leoli. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    // MARK: - Properies
    fileprivate var box: Box?

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
        GPassword.config { (options) in
            options.connectLineStart = .border
            options.isDrawTriangle = true
            options.normalstyle = .innerFill
        }

        box = Box(frame: CGRect(x: globalOptions.pointSpace, y: 100, width: UIScreen.main.bounds.width - 2 * globalOptions.pointSpace, height: 400))
        view.addSubview(box!)
    }
}

extension PasswordViewController: EventDelegate {
    func touchesEnded() {

    }


}
