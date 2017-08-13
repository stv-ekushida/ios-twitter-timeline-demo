//
//  HomeTimelineManager.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import SwiftTask
import ObjectMapper

typealias TwitterHomeTimelineTask = Task<Void, [Tweet], String>

final class HomeTimelineManager {
    
    let path = "statuses/home_timeline.json"
    
    /// ホームタイムライン情報を取得する
    ///
    /// - Returns: ホームタイムライン情報
    func fetch(count: Int) -> TwitterHomeTimelineTask{
        
        return TwitterHomeTimelineTask { (fulfil, reject) in
            
            let request = APIClient().urlRequest(path: self.path,
                                                 parameters: ["count": "\(count)"])
            
            request.perform { data, response, error in
                
                if let error = error {
                    reject(error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    reject("ホームタイムラインが取得できません")
                    return
                }
                
                let serializedData = try!
                    JSONSerialization.jsonObject(with: data,
                                                 options: .allowFragments)
                
                let json = serializedData as! [Any]
                
                let timeline: [Tweet] = json.flatMap {
                    Mapper<Tweet>().map(JSONObject: $0)
                }
                fulfil(timeline)
            }
        }
    }
}

