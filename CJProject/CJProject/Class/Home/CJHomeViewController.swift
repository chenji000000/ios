//
//  CJHomeViewController.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/24.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit
import DNSPageView

class CJHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        // 创建DNSPageStyle,设置样式
        let style = DNSPageStyle()
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleViewSelectedColor = UIColor.white
        style.titleViewBackgroundColor = UIColor.white
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = UIColor.withHex(hexString: "3388ff")
        style.bottomLineHeight = 2

        let titles = ["推荐", "分类", "VIP", "直播", "广播"]
        let viewControllers: [CJHomeBaseViewController] = [CJHomeRecommandViewController(), CJHomeClassifyViewController(), CJHomeVIPViewController(), CJHomeLiveViewController(), CJHomeBroadcastViewController()]
        for vc in viewControllers {
            vc.view.backgroundColor = UIColor.randomColor
//            self.addChild(vc)
        }
        let pageView = DNSPageView(frame: CGRect(x: 0, y: navigationBarHeight, width: CJScreenWidth, height: CJScreenHeight - navigationBarHeight - 44), style: style, titles: titles, childViewControllers: viewControllers)
        view.addSubview(pageView)
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
