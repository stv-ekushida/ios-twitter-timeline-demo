//
//  APIClient.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Social

/// APIの処理結果
///
/// - success: 成功
/// - failure: 失敗
enum Result {
    case success(Any)
    case failure(Error)
}

final class APIClient {
    
    static let baseURLString = "https://api.twitter.com/1.1/"
    
    func urlRequest(path: String, parameters: [String: Any]) -> SLRequest{
        
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
    
    
    /// APIをコールする
    ///
    /// - Returns: APIの処理結果
    func request(request: SLRequest,
                 completionHandler: @escaping (Result) -> Void = { _ in}) {
        
        request.perform { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            completionHandler(.success(data!))
        }
        
    }
}
