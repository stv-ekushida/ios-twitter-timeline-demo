//
//  IconImage.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/16.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import RealmSwift

class IconImage: Object {
    dynamic var profileId = ""
    dynamic var iconImageData: Data?    
    
    override static func primaryKey() -> String? {
        return "profileId"
    }    
}
