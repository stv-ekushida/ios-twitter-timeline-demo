//
//  HomeTimelineManagerTests.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/15.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import TwitterClientApp

class HomeTimelineManagerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        LoginManager().execute().success { account in
            Account.twitter = account
        }
    }
    
    func testRequestPath() {        
        XCTAssertEqual(HomeTimelineManager().path, "statuses/home_timeline.json")
    }
    
    func testFetchTimeLine() {
        HomeTimelineManager().fetch(count: 30).success { timeline in            
            XCTAssertEqual(timeline.count, 30)
        }
    }
    
    func testErrorDescription() {
        XCTAssertEqual(HometimelineError.offline.description, "通信環境の良い場所で再度お試しください。")
        XCTAssertEqual(HometimelineError.emptyTimeline.description, "タイムラインが取得できません。")
    }
}
