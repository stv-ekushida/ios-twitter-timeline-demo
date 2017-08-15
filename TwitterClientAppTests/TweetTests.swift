//
//  TweetTests.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/15.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import TwitterClientApp

class TweetTests: XCTestCase {

    func testSetTweet() {
        
        let json = [
            "id_str":"12345678",
            "text":"ツイート文言",
            "user": [
                "screen_name":"OnTheWaves94",
                "name": "eijikushida",
                "profile_image_url_https": "https://"
            ]
        ] as [String : Any]
        
        let tweet = Mapper<Tweet>().map(JSONObject: json)
        
        XCTAssertEqual(tweet?.id, "12345678")
        XCTAssertEqual(tweet?.text, "ツイート文言")
        XCTAssertEqual(tweet?.screenName, "OnTheWaves94")
        XCTAssertEqual(tweet?.name, "eijikushida")
        XCTAssertEqual(tweet?.profileImageURL, "https://")
    }
}
