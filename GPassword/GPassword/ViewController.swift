//
//  ViewController.swift
//  GPassword
//
//  Created by leoli on 2018/4/26.
//  Copyright © 2018年 leoli. All rights reserved.
//

let GWidth = UIScreen.main.bounds.width
let GHeight = UIScreen.main.bounds.height

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: GWidth, height: GHeight))
    var titles: [String] = ["Set password", "Verify password", "Modify password", "Open password track", "Close password track"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "GPassword")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "GPassword")
        }
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = PasswordViewController()
        if indexPath.row == 0 {
            vc.type = .set
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            vc.type = .verify
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            vc.type = .modify
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            
        } else if indexPath.row == 4 {
            
        }
    }
}
