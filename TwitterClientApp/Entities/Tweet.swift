//
//  Tweet.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import ObjectMapper

struct Tweet: Mappable {
    
    var id = ""
    var text = ""
    var screenName = ""
    var name = ""
    var profileImageURL = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id              <- map["id_str"]
        text            <- map["text"]
        screenName      <- map["user.screen_name"]
        name            <- map["user.name"]
        profileImageURL <- map["user.profile_image_url_https"]
    }
}
