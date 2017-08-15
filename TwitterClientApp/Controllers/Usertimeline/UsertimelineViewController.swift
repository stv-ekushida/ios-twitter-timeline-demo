//
//  UsertimelineViewController.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/14.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit
import SwiftTask
import STV_Extensions

final class UsertimelineViewController: UIViewController {
    
    var tweet: Tweet!
    
    /// ユーザタイムライン画面のインスタンスを取得する
    ///
    /// - Parameter tweet: ツイート情報
    /// - Returns: ユーザタイムライン画面ののインスタンス
    static func instance(tweet: Tweet) -> UsertimelineViewController {
        
        let vc = UIStoryboard.viewController(storyboardName: "Usertimeline", identifier: "UsertimelineViewController") as! UsertimelineViewController

        vc.tweet = tweet
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tweet.name
        
        
        UserTimelineManager().fetch(userId: tweet.id, count: 30).success { tweet  in
            
        }.failure { (error, _) in
            
        }
    }
}
