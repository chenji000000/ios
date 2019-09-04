//
//  Dictionary_merge.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import Foundation


extension Dictionary {
    mutating func merge<S>(param: S) where S: Sequence, S.Iterator.Element == (key: Key, value: Value) {
        for (k, v) in param {
            self[k] = v
        }
    }
}
