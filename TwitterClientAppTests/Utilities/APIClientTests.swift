//
//  APIClientTests.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/15.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
import Accounts
@testable import TwitterClientApp

class APIClientTests: XCTestCase {
    
    func testBaseURLString() {
        XCTAssertEqual(APIClient.baseURLString, "https://api.twitter.com/1.1/")
    }
    
    func testAPIClientRequest_ForURL() {
        let request = APIClient().urlRequest(path: "statuses/home_timeline.json",
                                             parameters: [:])
        XCTAssertEqual(request.url.absoluteString, "https://api.twitter.com/1.1/statuses/home_timeline.json")
    }
    
    func testAPIClientRequest_ForParameter() {
        let request = APIClient().urlRequest(path: "statuses/home_timeline.json",
                                             parameters: ["count":"50"])
        
        let parameter = request.parameters.first!
        XCTAssertEqual(parameter.value as! String, "50")
        XCTAssertEqual(parameter.key as! String, "count")
    }    
}
