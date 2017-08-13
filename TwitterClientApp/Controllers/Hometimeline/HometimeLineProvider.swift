//
//  HometimeLineProvider.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class HometimeLineProvider: NSObject {
    
    fileprivate var tweets = [Tweet]()
    
    func set(tweets: [Tweet]) {
        self.tweets = tweets
    }
    
    func tweet(index: Int) -> Tweet {
        return tweets[index]
    }
}

//MARK : - UITableViewDataSource
extension HometimeLineProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView
            .dequeueReusableCell(withIdentifier: TimelineTableViewCell.identifier,
                                 for: indexPath) as? TimelineTableViewCell
        cell?.item = tweets[indexPath.row]
        return cell!
    }
}
