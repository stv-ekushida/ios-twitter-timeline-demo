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
        loadHomeTimeline()
    }
    
    /// ホームタイムラインを取得する
    private func loadHomeTimeline() {

        let manager = LoginManager()
        
        manager.execute().success { account in
            
            Account.twitter = account
            HomeTimelineManager().fetch(count: 5).success({ (timeline) -> Void in
                
                for tweet in timeline {
                    print(tweet.text)
                }
                
            }).failure({ (error, isCanceled) in
                
                guard let error = error else {
                    return
                }
                
                print(error)
            })
            
        }.failure { (error, isCanceled) in
                
            guard let _ = error else{
                return
            }
            manager.transitTwitterSettings()            
        }
    }
}

