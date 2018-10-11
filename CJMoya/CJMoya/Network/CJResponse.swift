//
//  CJResponse.swift
//  CJMoya
//
//  Created by 陈吉 on 2018/10/11.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import Foundation

var cjResponseCode = CJResponseCode()

struct CJResponseCode {
    let successCode = 200 //请求成功
}



struct CJResponse: Codable {
    var httpCode: Int
    var msg: String
}
