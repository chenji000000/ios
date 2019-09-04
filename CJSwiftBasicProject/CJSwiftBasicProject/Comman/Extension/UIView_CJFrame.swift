//
//  UIView_CJFrame.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import Foundation

extension UIView {
    //位置x
    var x:CGFloat{
        
        get{
            return frame.origin.x
        }
        
        set{
            var temp: CGRect = frame
            //newValue默认参数
            temp.origin.x = newValue
            frame = temp
        }
    }
    
    //位置y
    var y:CGFloat{
        
        get{
            return frame.origin.y
        }
        
        set{
            var temp: CGRect = frame
            //newValue默认参数
            temp.origin.y = newValue
            frame = temp
        }
    }
    
    //宽
    var width:CGFloat{
        
        get{
            return frame.size.width
        }
        
        set{
            var temp: CGRect = frame
            temp.size.width = newValue
            frame = temp
        }
    }
    
    //高
    var height:CGFloat{
        
        get{
            return frame.size.height
        }
        
        set{
            var temp: CGRect = frame
            temp.size.height = newValue
            frame = temp
        }
    }
    
    //左
    var left: CGFloat{
        
        get{
            return x
        }
        
        set{
            x = newValue
        }
    }
    
    //右
    var right: CGFloat{
        
        get{
            return x + width
        }
        
        set{
            x = newValue - width
        }
    }
    
    //上
    var top: CGFloat{
        
        get{
            return y
        }
        
        set{
            y = newValue
        }
    }
    
    //下
    var bottom:CGFloat{
        
        get{
            return y + height
        }
        
        set{
            y = newValue - height
        }
    }
    
    //中心x
    var centerX:CGFloat{
        
        get{
            return center.x
        }
        
        set{
            center = CGPoint(x: newValue, y: center.y)
        }
    }
    
    //中心y
    var centerY:CGFloat{
        
        get{
            return center.y
        }
        
        set{
            center = CGPoint(x: center.x, y: newValue)
        }
    }
    
    //宽的一半
    var middleX: CGFloat{
        
        get{
            return width * 0.5
        }
    }
    
    //高的一半
    var middleY: CGFloat{
        
        get{
            return height * 0.5
        }
    }
}
