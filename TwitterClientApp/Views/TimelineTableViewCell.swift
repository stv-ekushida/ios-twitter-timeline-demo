//
//  TimelineTableViewCell.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit
import AlamofireImage

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
            
            guard let profileId = item?.id else {
                assertionFailure("プロフィールIDが設定されていない")
                return
            }

            if let iconImage = IconImageManager.findByID(profileId: profileId),
                let data = iconImage.iconImageData {
                iconImageView.image = UIImage(data: data)
                return
            }
            
            guard let profileImageURL = item?.profileImageURL else {
                assertionFailure("プロフィールアイコンが設定されていない")
                return
            }
            
            if let url = URL.init(string: profileImageURL) {
                iconImageView.af_setImage(withURL: url , completion: { data in
                    let savedIconImage = IconImage()
                    savedIconImage.profileId = profileId
                    savedIconImage.iconImageData = data.data
                    IconImageManager.add(model: savedIconImage)
                })
            }
        }
    }
}
