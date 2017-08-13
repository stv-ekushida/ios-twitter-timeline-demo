//
//  Router.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "https://api.twitter.com/1.1/"
    
    case homeTimeLine([String: Any])
    case userTimeLine([String: Any])
        
    /// URLリクエストを作成する
    ///
    /// - Returns: URLリクエスト
    func asURLRequest() throws -> URLRequest {
        
        let (method, path, parameters): (HTTPMethod, String, [String: Any]) = {
            
            switch self {
            case .homeTimeLine(let params):
                return (.get, "statuses/user_timeline.json", params)

            case .userTimeLine(let params):
                return (.get, "statuses/user_timeline.json", params)
            }

        }()
    
        let url = URL(string: Router.baseURLString)
        var urlRequest = URLRequest(url: url!.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
