//
//  ViewController.swift
//  GPassword
//
//  Created by leoli on 2018/4/26.
//  Copyright © 2018年 leoli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        GPassword.config { (options) in
            options.isInnerStroke = false
            options.isOuterStroke = false
        }

        let point = Point.init(frame: CGRect.init(x: 40, y: 100, width: 80, height: 80))
        view.addSubview(point)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

