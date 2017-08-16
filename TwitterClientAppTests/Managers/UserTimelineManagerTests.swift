//
//  UserTimelineManagerTests.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/15.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import TwitterClientApp

class UserTimelineManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        LoginManager().execute().success { account in
            Account.twitter = account
        }
    }
    
    func testRequestPath() {
        XCTAssertEqual(UserTimelineManager().path, "statuses/user_timeline.json")
    }
    
    func testFetchTimeLine() {
        UserTimelineManager().fetch(screenName: "OnTheWaves94", count: 10).success { timeline in
            XCTAssertEqual(timeline.count, 10)
            XCTAssertEqual(timeline.first?.screenName, "OnTheWaves94")
        }
    }
    
    func testErrorDescription() {
        XCTAssertEqual(UsertimelineError.offline.description, "通信環境の良い場所で再度お試しください。")
        XCTAssertEqual(UsertimelineError.emptyTimeline.description, "タイムラインが取得できません。")
    }
}
