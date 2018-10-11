//
//  HitView.swift
//  CJHitTest
//
//  Created by 陈吉 on 2018/10/11.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit

class HitView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var identifier: String?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("进入A_View---hitTest withEvent ---")
        if !self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01 {
            return nil
        }
        
        if self.point(inside: point, with: event) {
            for subView in self.subviews.reversed() {
                let convertedPoint = subView.convert(point, from: self)
                if let hitTestView = subView.hitTest(convertedPoint, with: event) {
                    
                    print("离开A_View---hitTest withEvent ---hitTestView:\(hitTestView)")
                    return hitTestView
                }
            }
            print("离开A_View---hitTest withEvent ---hitTestView:\(self)")
            return self
        }
        return nil
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("A_View--- pointInside withEvent ---")
        let isInside = super.point(inside: point, with: event)
        print("A_view--- pointInside withEvent --- isInside:\(isInside)")
        return isInside
    }
    
    override var description: String {
        return self.identifier ?? "nil"
    }

}
