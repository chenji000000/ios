//
//  CJDefineFile.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import Foundation
import UIKit

// 屏幕尺寸
let ScreenSize = UIScreen.main.bounds.size
let ScreenWidth = ScreenSize.width
let ScreenHeight = ScreenSize.height

let ScreenLengthMax = max(ScreenWidth, ScreenHeight)
let ScreenLengthMin = min(ScreenWidth, ScreenHeight)

// 是否pad
let ISPad = UIDevice.current.userInterfaceIdiom == .pad
// iphone4
let Device_Iphone_4 = __CGSizeEqualToSize(CGSize(width: 640/2, height: 960/2), ScreenSize)
// iphone5
let Device_Iphone_5 = __CGSizeEqualToSize(CGSize(width: 640/2, height: 1136/2), ScreenSize)
// iphone6
let Device_Iphone_6 = __CGSizeEqualToSize(CGSize(width: 750/2, height: 1334/2), ScreenSize)
// iphone6+
let Device_Iphone_6P = __CGSizeEqualToSize(CGSize(width: 1242/2, height: 2208/2), ScreenSize)
// iphoneX
let Device_Iphone_X = __CGSizeEqualToSize(CGSize(width: 1125/3, height: 2436/3), ScreenSize)
// iphoneXr
let Device_Iphone_XR = __CGSizeEqualToSize(CGSize(width: 828/2, height: 1792/2), ScreenSize)
// iphoneXs
let Device_Iphone_XS = __CGSizeEqualToSize(CGSize(width: 1125/3, height: 2436/3), ScreenSize)
// iphoneXs Max
let Device_Iphone_XS_MAX = __CGSizeEqualToSize(CGSize(width: 1242/3, height: 2688/3), ScreenSize)
// 是否属于X系列
let IsIphoneX = (Device_Iphone_X || Device_Iphone_XR || Device_Iphone_XS || Device_Iphone_XS_MAX)

// 状态栏高度
let StatusBar_Height: CGFloat = IsIphoneX ? 44.0 : 20.0
// 顶部总高度=状态栏+导航栏
let Top_Height: CGFloat = IsIphoneX ? 88.0 : 64.0
// 底部安全区域高度
let Bottom_Safe_Height: CGFloat = IsIphoneX ? 34.0 : 0.0
// 底部总高度=49+安全区域
let TabBar_Height: CGFloat = IsIphoneX ? 83.0 : 49.0

// 距离边缘宽度
let Common_Margin: CGFloat = 15.0

let NURSEID = UserDefaults.standard.value(forKey: "NURSEID")
let NURSENAME = UserDefaults.standard.value(forKey: "NURSENAME")


