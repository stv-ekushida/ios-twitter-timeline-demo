//
//  TimelineTableViewCellTests.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/15.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import TwitterClientApp

class TimelineTableViewCellTests: XCTestCase {
    
    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: TimelineTableViewCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Hometimeline", bundle: nil)
        let controller = storyboard
            .instantiateViewController(
                withIdentifier: "HometimelineViewController")
            as! HometimelineViewController
        
        _ = controller.view
        
        tableView = controller.timelineTableView
        tableView?.dataSource = dataSource
        
        cell = tableView?.dequeueReusableCell(
            withIdentifier: "TimelineTableViewCell",
            for: IndexPath(row: 0, section: 0)) as! TimelineTableViewCell
    }
    
    func testSetTweetCell() {
        
        let json = [
                    "id_str":"12345678",
                    "text":"ツイート文言",
                    "user": [
                        "screen_name":"OnTheWaves94",
                        "name": "eijikushida",
                        "profile_image_url_https": "https://"
                    ]
        ] as [String : Any]
        
        cell.item = Mapper<Tweet>().map(JSONObject: json)
        
        XCTAssertEqual(cell.screenNameLabel.text, "OnTheWaves94")
        XCTAssertEqual(cell.nameLabel.text, "eijikushida")
        XCTAssertEqual(cell.tweetLabel.text, "ツイート文言")
    }
}

extension TimelineTableViewCellTests {
    
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
