//
//  CJHUD.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import Foundation
import PKHUD

public func showHUD(state: Bool = true) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.26) {
        if state {
            HUD.show(.progress)
        } else {
            HUD.hide()
        }
    }
}

public func hideHUD() {
    HUD.hide()
}

public func remindHUD(text: String) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.26) {
        HUD.show(.label(text))
        HUD.hide(afterDelay: 2)
    }
}
