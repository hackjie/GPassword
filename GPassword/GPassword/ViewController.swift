//
//  ViewController.swift
//  GPassword
//
//  Created by leoli on 2018/4/26.
//  Copyright © 2018年 leoli. All rights reserved.
//

let GWidth = UIScreen.main.bounds.width

import UIKit

class ViewController: UIViewController {

    var shapeLayer: CAShapeLayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        GPassword.config { (options) in
            options.connectLineStart = .border
            options.isDrawTriangle = true
            options.normalstyle = .innerFill
        }

        let box = Box(frame: CGRect(x: globalOptions.pointSpace, y: 100, width: UIScreen.main.bounds.width - 2 * globalOptions.pointSpace, height: 400))
        view.addSubview(box)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

