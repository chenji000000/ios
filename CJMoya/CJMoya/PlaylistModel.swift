//
//  PlaylistModel.swift
//  CJMoya
//
//  Created by 陈吉 on 2018/10/10.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import Foundation

struct PlaylistModel: MapCodable {
    var song: [Song]
}

struct Song: Codable {
    var artist: String
    var title: String
    
}
