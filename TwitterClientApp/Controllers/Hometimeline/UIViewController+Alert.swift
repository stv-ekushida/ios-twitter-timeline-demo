//
//  UIViewController+Alert.swift
//  TwitterClientApp
//
//  Created by Eiji Kushida on 2017/08/13.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// 警告用アラート
    ///
    /// - Parameter message: 警告メッセージ
    func warning(message: String) {
        
        let alert = UIAlertController(title: "警告",
                                      message: message,
                                      preferredStyle:  .alert)
        
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default,
                                          handler:{
            (action: UIAlertAction!) -> Void in
        })
        
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
