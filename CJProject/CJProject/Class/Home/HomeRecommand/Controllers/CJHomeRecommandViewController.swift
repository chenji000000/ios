//
//  CJHomeRecommandViewController.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/24.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

//首页推荐控制器
class CJHomeRecommandViewController: CJHomeBaseViewController {
    
    //MARK-数据模型
    private var recommandAdvertList: [RecommnedAdvertModel]? //穿插的广告数据
    lazy var viewModel: CJHomeRecommandViewModel = {
        return CJHomeRecommandViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
        loadRecommandAdData()
    }
    
    private func loadData() {
        viewModel.updateBlock = { [unowned self] in
            print("========\(self.viewModel.homeRecommandList)")
        }
        viewModel.refreshDataSource()
    }
    
    private func loadRecommandAdData() {
        //首页穿插广告接口请求
        CJRecommandProvider.request(.recommandAdList) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let advertList = JSONDeserializer<RecommnedAdvertModel>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.recommandAdvertList = advertList as? [RecommnedAdvertModel]
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
