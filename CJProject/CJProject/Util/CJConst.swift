//
//  Const.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/24.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON

let CJScreenWidth = UIScreen.main.bounds.width
let CJScreenHeight = UIScreen.main.bounds.height

let isIphoneX = CJScreenHeight == 812 ? true : false
let navigationBarHeight : CGFloat = isIphoneX ? 88 : 64
let tabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49

