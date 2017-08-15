//
//  NetworkManager.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/15.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import ReachabilitySwift

final class NetworkManager {
    
    /// ネットワークの接続状況を確認する
    ///
    /// - Returns: 接続可 / 不可
    func canNetwork() -> Bool {
        
        if let isReachable = Reachability()?.isReachable {
            return isReachable
        }
        return false
    }
}
