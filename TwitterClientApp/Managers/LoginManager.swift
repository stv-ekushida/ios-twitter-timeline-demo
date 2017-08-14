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

typealias TwitterLoginTask = Task<Void, ACAccount?, LoginError>

enum LoginError: Error {
    case offline
    case notAvailable
    case notApproval
}

extension LoginError: CustomStringConvertible {
    var description: String {
        switch self {
        case .offline:
            return "通信環境の良い場所で再度お試しください。"
        case .notAvailable:
            return "Twitterが利用できません。"
        case .notApproval:
            return "Twitterの利用が承認されませんでした。"
        }
    }
}

final class LoginManager {

    /// ログイン処理の実行
    func execute() -> TwitterLoginTask{
        
        return TwitterLoginTask { (fulfil, reject) in
            
            if !SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                reject(LoginError.notAvailable)
                return
            }
            
            let account = ACAccountStore()
            let type = account.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
            
            account.requestAccessToAccounts(with: type, options: nil) { granted, error in
                
                guard granted else {
                    reject(LoginError.notApproval)
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
}

