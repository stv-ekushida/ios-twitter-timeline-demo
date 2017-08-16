//
//  IconImageManager.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/16.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import RealmSwift

final class IconImageManager {
    
    static let dao = RealmDaoHelper<IconImage>()
    
    /// アイコン画像の登録
    ///
    /// - Parameter model: アイコン画像情報
    static func add(model: IconImage) {
        
        if let _ = IconImageManager.findByID(profileId: model.profileId) {
            return
        }
        let object = IconImage()
        object.profileId = model.profileId
        object.iconImageData = model.iconImageData
        IconImageManager.dao.add(d: object)
    }
    
    /// アイコン画像を削除する
    static func deleteAll() {
        dao.deleteAll()
    }
    
    /// 該当のアイコンを取得する
    ///
    /// - Parameter profileId: プロフィールID
    /// - Returns: アイコン画像情報
    static func findByID(profileId: String) -> IconImage? {
        guard let object = dao.findFirst(key: profileId as AnyObject) else {
            return nil
        }        
        return object
    }
}
