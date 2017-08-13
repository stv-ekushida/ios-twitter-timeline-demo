//
//  LoginManager.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Social
import Accounts
import SwiftTask

typealias TwitterLoginTask = Task<Void, ACAccount?, String>

final class LoginManager {

    /// ログイン処理の実行
    func execute() -> TwitterLoginTask{
        
        return TwitterLoginTask { (fulfil, reject) in
            
            if !SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                reject("Twitterが利用できません。")
                return
            }
            
            let account = ACAccountStore()
            let type = account.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
            
            account.requestAccessToAccounts(with: type, options: nil) { granted, error in
                
                guard granted else {
                    reject("Twitterの利用が承認されませんでした。")
                    return
                }
                
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return
                }
                
                let accounts = account.accounts(with: type)
                
                // 複数あるであろうアカウントの中から最初の一つを取得
                if let account = accounts?.first as? ACAccount {
                    fulfil(account)
                }
            }            
        }
    }
    
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

