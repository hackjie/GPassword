//
//  AppDelegate.swift
//  GPassword
//
//  Created by leoli on 2018/4/26.
//  Copyright © 2018年 leoli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let vc = ViewController()
        let nav = UINavigationController(rootViewController: vc)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}

