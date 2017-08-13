//
//  APIClient.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Social

final class APIClient {
    
    static let baseURLString = "https://api.twitter.com/1.1/"
    
    /// リクエストの生成
    ///
    /// - Parameters:
    ///   - path: URLのパス
    ///   - parameters: リクエストパラメタ
    /// - Returns: HTTPリクエスト
    func urlRequest(path: String, parameters: [String: Any]) -> SLRequest {
        
        let url = URL(string: APIClient.baseURLString)?.appendingPathComponent(path)
                
        let request = SLRequest(
            forServiceType: SLServiceTypeTwitter,
            requestMethod: .GET,
            url: url,
            parameters: parameters
        )
        request?.account = Account.twitter
        return request!
    }
}
