//
//  CJAdvertisingModel.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import UIKit

class CJAdvertisingModel: NSObject {
    @objc var adUrl: URL?
    @objc var createTime: String?
    @objc var hospitalNames: String?
    @objc var ID: String?
    @objc var imageId: String?
    @objc var title: String?
    @objc var content: String?
    //为3时跳转指定原生页面
    @objc var contentType: String?
    @objc var cover: String?
    
    //属性名字和后台返回字段不一致
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID": "id"]
    }

}
