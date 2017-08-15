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
import SVProgressHUD

final class UsertimelineViewController: UIViewController, Timelinable {
    
    //MARK:- IBOutlet    
    @IBOutlet weak var timelineTableView: UITableView!
    
    //MARK: - Properties
    fileprivate let dataSource = TimeLineProvider()
    private var tweet: Tweet!
    
    /// ユーザタイムライン画面のインスタンスを取得する
    ///
    /// - Parameter tweet: ツイート情報
    /// - Returns: ユーザタイムライン画面ののインスタンス
    static func instance(tweet: Tweet) -> UsertimelineViewController {
        
        let vc = UIStoryboard.viewController(storyboardName: "Usertimeline",
                                             identifier: "UsertimelineViewController") as! UsertimelineViewController
        vc.tweet = tweet
        return vc
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadTimeline()
    }
    
    //MARK: - Internal Methods
    internal func setup() {
        self.title = tweet.name
        timelineTableView.estimatedRowHeight = 88
        timelineTableView.rowHeight = UITableViewAutomaticDimension
        timelineTableView.dataSource = dataSource
    }
    
    /// ユーザタイムラインの習得
    internal func loadTimeline() {
        SVProgressHUD.show()
        
        UserTimelineManager().fetch(screenName: tweet.screenName, count: 30)
            .success {[weak self] timeline  in
            
            DispatchQueue.main.async {
                self?.dataSource.set(tweets: timeline)
                self?.timelineTableView.reloadData()
            }            
        }.failure {[weak self] (error, _) in
            
            guard let error = error else{
                return
            }
            self?.warning(message: error.description)
        }.then { (_, _) -> Void in
            SVProgressHUD.dismiss()
        }
    }
}
