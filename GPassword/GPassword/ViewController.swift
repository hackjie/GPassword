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
            options.connectionLineColor = .blue
        }
        view.backgroundColor = LockManager.default.lockOptions.connectionLineColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

