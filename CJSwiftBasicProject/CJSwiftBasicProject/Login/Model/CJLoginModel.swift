//
//  CJLoginModel.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import UIKit

class CJLoginModel: NSObject {
    @objc var name: String?
    @objc var itsId: String?
    //子model嵌套
    @objc var attributesMap: CJLoginAttributesMapModel?
    //子model数组
    @objc var hospitalsList:Array<CJHospitalModel>?
    
    //属性名字和后台返回字段不一致
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        
        return ["itsId":"id"]
    }
    
    //因为有子model数据,需要重写如下方法
    override func mj_keyValuesDidFinishConvertingToObject() {
        if self.hospitalsList != nil {
            
            let list = CJHospitalModel.mj_objectArray(withKeyValuesArray: self.hospitalsList)
            if list != nil {
                self.hospitalsList = list! as NSArray as? [CJHospitalModel]
            }
        }
    }
}

class CJLoginAttributesMapModel: NSObject {
    @objc var userDeptIds:String?
    @objc var userGudiceTag:Int = 0
    @objc var yunXinInfor:String?
}

class CJHospitalModel: NSObject {
    @objc var bedNum = 0
    @objc var openFlag = false
    @objc var sortOrder:String?
    @objc var satisfaction:String?
    @objc var name:String?
    @objc var nurseAssessFlag:String?
    @objc var followUp:String?
    @objc var nurseTrain:String?
    @objc var inner:String?
    @objc var ID:String?
    
    //属性名字和后台返回字段不一致
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        
        return ["ID":"id"]
    }
}
