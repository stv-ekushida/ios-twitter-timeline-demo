//
//  TimelineTableViewCell.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class TimelineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var item: Tweet? {
        didSet {
            nameLabel.text = item?.name
            screenNameLabel.text = item?.screenName
            tweetLabel.text = item?.text
        }
    }
}
