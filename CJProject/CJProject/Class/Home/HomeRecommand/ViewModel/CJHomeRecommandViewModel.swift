//
//  CJHomeRecommandViewModel.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/25.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import Foundation
import SwiftyJSON
import HandyJSON

class CJHomeRecommandViewModel: NSObject {
    //MARK --  数据模型
    var cjHomeRecommandModel: CJHomeRecommandModel?
    var homeRecommandList: [HomeRecommendModel]?
    var recommandList: [RecommendListModel]?
    var focus: FocusModel?
    var squareList: [SquareModel]?
    var topBuzzList: [TopBuzzModel]?
    var guessYouLikeList: [GuessYouLikeModel]?
    var paidCategoryList: [PaidCategoryModel]?
    var playist: PlaylistModel?
    var oneKeyListenList: [OneKeyListenModel]?
    var liveList: [LiveModel]?
    //MARK -- 数据源更新
    typealias AddDataBlock = () -> Void
    var updateBlock: AddDataBlock?
}
//Mark - 请求数据
extension CJHomeRecommandViewModel {
    func refreshDataSource() {
        //首页推荐接口请求
        CJRecommandProvider.request(.recommandList) { (result) in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<CJHomeRecommandModel>.deserializeFrom(json: json.description) {
                    //从字符串转换为对象实例
                    self.cjHomeRecommandModel = mappedObject
                    self.homeRecommandList = mappedObject.list
                    if let recommandList = JSONDeserializer<RecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                        self.recommandList = recommandList as? [RecommendListModel]
                    }
                    if let focus = JSONDeserializer<FocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.focus = focus
                    }
                    if let square = JSONDeserializer<SquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.squareList = square as? [SquareModel]
                    }
                    if let topBuzz = JSONDeserializer<TopBuzzModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description) {
                        self.topBuzzList = topBuzz as? [TopBuzzModel]
                    }
                    if let oneKeyListen = JSONDeserializer<OneKeyListenModel>.deserializeModelArrayFrom(json: json["list"][9]["list"].description) {
                        self.oneKeyListenList = oneKeyListen as? [OneKeyListenModel]
                    }
                    if let live = JSONDeserializer<LiveModel>.deserializeModelArrayFrom(json: json["list"][14]["list"].description) {
                        self.liveList = live as? [LiveModel]
                    }
                    self.updateBlock?()
                }
            }
        }
    }
}

//Mark -- collectionView数据
extension CJHomeRecommandViewModel {
    func numberOfSections(collectionView: UICollectionView) -> Int {
        return (self.homeRecommandList?.count) ?? 0
    }
    
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return 1
    }
    func insertForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    func minimumInteritemSpacingForSectionAt(section: Int) -> CGFloat {
        return 0
    }
    func minimumLineSpacingForSectionAt(section: Int) -> CGFloat {
        return 0
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let HeaderAndFooterHeight: Int = 90
        let itemNums = (self.homeRecommandList?[indexPath.section].list?.count)!/3
        let count = self.homeRecommandList?[indexPath.section].list?.count
        let moduleType = self.homeRecommandList?[indexPath.section].moduleType
        if moduleType == "focus" {
            return CGSize(width: CJScreenWidth, height: 360)
        } else if moduleType == "square" || moduleType == "topBuzz" {
            return CGSize.zero
        } else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" || moduleType == "live" {
            return CGSize(width: CJScreenWidth, height: CGFloat(HeaderAndFooterHeight+180*itemNums))
        } else if moduleType == "categoriesForShort" || moduleType == "palylist" || moduleType == "categoriesForExplore" {
            return CGSize(width: CJScreenWidth, height: CGFloat(HeaderAndFooterHeight+120*count!))
        } else if moduleType == "ad" {
            return CGSize(width: CJScreenWidth, height: 240)
        } else if moduleType == "oneKeyListen" {
            return CGSize(width: CJScreenWidth, height: 180)
        } else {
            return .zero
        }
    }
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommandList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" || moduleType == "ad" || section == 18 {
            return CGSize.zero
        } else {
            return CGSize(width: CJScreenWidth, height: 40)
        }
    }
    
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommandList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" {
            return CGSize.zero
        } else {
            return CGSize(width: CJScreenWidth, height: 10)
        }
        
    }
    
}
