//
//  APIClient.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Alamofire

/// APIの処理結果
///
/// - success: 成功
/// - failure: 失敗
enum Result {
    case success(Any)
    case failure(Error)
}

final class APIClient {
    
    /// APIをコールする
    ///
    /// - Returns: APIの処理結果
    func request(router: Router,
                 completionHandler: @escaping (Result) -> Void = {
        _ in}) {
        
        Alamofire.request(router).responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler(Result.success(value))
                
            case .failure:
                
                if let error = response.result.error {
                    completionHandler(Result.failure(error))
                } else {
                    assertionFailure("エラーのインスタンスがnil")                    
                }
            }
        }
    }
}
