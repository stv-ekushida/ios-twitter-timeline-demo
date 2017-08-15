//
//  Timelinable.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/15.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol Timelinable {
    var timelineTableView: UITableView! {get}
    func setup()
    func loadTimeline()
}
