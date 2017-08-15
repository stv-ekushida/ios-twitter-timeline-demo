//
//  HometimelineViewController.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit
import SwiftTask
import SVProgressHUD

final class HometimelineViewController: UIViewController, Timelinable {
    
    //MARK:- IBOutlet
    @IBOutlet weak var timelineTableView: UITableView!
    
    //MARK: - Properties
    fileprivate let dataSource = TimeLineProvider()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadTimeline()
    }
    
    //MARK: - Private Methods
    internal func setup() {
        timelineTableView.estimatedRowHeight = 88
        timelineTableView.rowHeight = UITableViewAutomaticDimension
        timelineTableView.dataSource = dataSource
        timelineTableView.delegate = self
    }
    
    /// ホームタイムラインを取得する
    internal func loadTimeline() {
        
        SVProgressHUD.show()
        
        LoginManager().execute().success { account in
            
            Account.twitter = account
            HomeTimelineManager().fetch(count: 20).success({[weak self] (timeline) -> Void in
                
                DispatchQueue.main.async {
                    self?.dataSource.set(tweets: timeline)
                    self?.timelineTableView.reloadData()
                }
                
            }).failure({[weak self] (error, _) in
                
                guard let error = error else {
                    return
                }
                self?.warning(message: error.description)
            })
            
        }.failure {[weak self] (error, _) in
                
            guard let error = error else{
                return
            }
            
            switch error {
            case.notAvailable:
                SettingsManager().transitTwitterSettings()
            default:
                self?.warning(message: error.description)
            }
        }.then {(_, _) -> Void in
            SVProgressHUD.dismiss()
        }
    }
}

// MARK: - UITableViewDelegate
extension HometimelineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tweet = dataSource.tweet(index: indexPath.row)
        let vc = UsertimelineViewController.instance(tweet: tweet)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

