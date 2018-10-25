//
//  CJHomeBaseViewController.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/24.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit
import DNSPageView

//首页父视图控制器
class CJHomeBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
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

extension CJHomeBaseViewController: DNSPageReloadable {
    func titleViewDidSelectedSameTitle() {
        print("重复点击了标题")
    }
    
    func contentViewDidEndScroll() {
        print("contentView滑动结束")
    }
}
