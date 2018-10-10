//
//  ChannelModel.swift
//  CJMoya
//
//  Created by 陈吉 on 2018/10/10.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import Foundation

struct ChannelModel: MapCodable {
    var channels: [Channel]
}

struct Channel: Codable {
    var nameEn: String
    var segId: String
    var abbrEn: String
    var name: String
    var channelId: String
    
    enum CodingKeys: String, CodingKey {
        case nameEn = "name_en"
        case segId = "seq_id"
        case abbrEn = "abbr_en"
        case name
        case channelId = "channel_id"
    }
}


