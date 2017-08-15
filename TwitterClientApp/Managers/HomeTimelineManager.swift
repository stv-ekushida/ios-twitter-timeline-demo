//
//  HomeTimelineManager.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import SwiftTask
import ObjectMapper

typealias TwitterHomeTimelineTask = Task<Void, [Tweet], HometimelineError>

enum HometimelineError: Error {
    case offline
    case emptyTimeline
}

extension HometimelineError: CustomStringConvertible {
    var description: String {
        switch self {
        case .offline:
            return "通信環境の良い場所で再度お試しください。"
        case .emptyTimeline:
            return "タイムラインが取得できません。"
        }
    }
}

final class HomeTimelineManager {
    
    let path = "statuses/home_timeline.json"
    
    /// ホームタイムライン情報を取得する
    ///
    /// - Returns: ホームタイムライン情報
    func fetch(count: Int) -> TwitterHomeTimelineTask{
        
        return TwitterHomeTimelineTask { (fulfil, reject) in
            
            guard NetworkManager().canNetwork() else {
                reject(HometimelineError.offline)
                return
            }
                        
            let request = APIClient().urlRequest(path: self.path,
                                                 parameters: ["count": "\(count)"])
            
            request.perform { data, response, error in
                
                if let _ = error {
                    assertionFailure("APIエラーが発生しました。")
                    return
                }
                
                guard let data = data else {
                    reject(HometimelineError.emptyTimeline)
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

