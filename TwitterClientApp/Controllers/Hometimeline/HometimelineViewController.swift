//
//  HometimelineViewController.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit
import SwiftTask

final class HometimelineViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var timelineTableView: UITableView!
    
    //MARK: - Properties
    fileprivate let dataSource = HometimeLineProvider()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimeLine()
        loadHomeTimeline()
    }
    
    //MARK: - Private Methods
    private func setupTimeLine() {
        timelineTableView.estimatedRowHeight = 88
        timelineTableView.rowHeight = UITableViewAutomaticDimension
        timelineTableView.dataSource = dataSource
        timelineTableView.delegate = self
    }
    
    /// ホームタイムラインを取得する
    private func loadHomeTimeline() {
        
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
                self?.warning(message: error)
            })
            
        }.failure { (error, _) in
                
            guard let _ = error else{
                return
            }
            SettingsManager().transitTwitterSettings()
        }
    }
}

// MARK: - UITableViewDelegate
extension HometimelineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tweet = dataSource.tweet(index: indexPath.row)
        print(tweet.name)
    }
}

