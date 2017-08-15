//
//  UserTimelineManager.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/14.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import SwiftTask
import ObjectMapper

typealias TwitterUserTimelineTask = Task<Void, [Tweet], UsertimelineError>

enum UsertimelineError: Error {
    case offline
    case emptyTimeline
}

extension UsertimelineError: CustomStringConvertible {
    var description: String {
        switch self {
        case .offline:
            return "通信環境の良い場所で再度お試しください。"
        case .emptyTimeline:
            return "タイムラインが取得できません。"
        }
    }
}

final class UserTimelineManager {
    
    let path = "statuses/user_timeline.json"
    
    /// ユーザタイムライン情報を取得する
    ///
    /// - Returns: ユーザタイムライン情報
    func fetch(userId: String, count: Int) -> TwitterUserTimelineTask{
        
        return TwitterUserTimelineTask { (fulfil, reject) in
            
            guard NetworkManager().canNetwork() else {
                reject(UsertimelineError.offline)
                return
            }
            
            let request = APIClient().urlRequest(path: self.path,
                                                 parameters: [
                                                    "user_id": userId,
                                                    "count": "\(count)"])
            
            request.perform { data, response, error in
                
                if let error = error {
                    reject(error as! UsertimelineError)
                    return
                }
                
                guard let data = data else {
                    reject(UsertimelineError.emptyTimeline)
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
