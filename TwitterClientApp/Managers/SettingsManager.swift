//
//  SettingsManager.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/14.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class SettingsManager {
    
    /// Twitterの設定画面へ遷移する
    func transitTwitterSettings() {
        
        if let url = URL(string:"App-prefs:root=TWITTER") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
