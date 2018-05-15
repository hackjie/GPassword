//
//  ViewController.swift
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

