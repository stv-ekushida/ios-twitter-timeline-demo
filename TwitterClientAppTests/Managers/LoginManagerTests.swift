//
//  LoginManagerTests.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/15.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import TwitterClientApp

class LoginManagerTests: XCTestCase {
    
    func testLoginManagerExecute() {
        
        LoginManager().execute().success { account in
            XCTAssertNotNil(account)
        }
    }
    
    func testErrorDescription() {
        XCTAssertEqual(LoginError.offline.description, "通信環境の良い場所で再度お試しください。")
        XCTAssertEqual(LoginError.notAvailable.description, "Twitterが利用できません。")
        XCTAssertEqual(LoginError.notApproval.description, "Twitterの利用が承認されませんでした。")
    }
}
