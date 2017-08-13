//
//  ViewController.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit
import SwiftTask

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginManager().execute().success { account in
            print("OK")
        }.failure { (error, isCanceled) in
            print(error)
        }
    }
}

