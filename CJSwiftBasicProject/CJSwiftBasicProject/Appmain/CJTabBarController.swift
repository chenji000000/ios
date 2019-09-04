//
//  CJTabBarController.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import UIKit

class CJTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addChildViewController(controller: CJTrainMainViewController(), title: "首页", defaultImage: UIImage(named: "shouye")!, selectedImage: UIImage(named: "shouyes")!)
        self.addChildViewController(controller: CJMyMainViewController(), title: "我的", defaultImage: UIImage(named: "wode")!, selectedImage: UIImage(named: "wodes")!)
    }
    
    func addChildViewController(controller: UIViewController, title: String, defaultImage: UIImage, selectedImage: UIImage) {
        controller.tabBarItem = UITabBarItem(title: title, image: defaultImage.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage.withRenderingMode(.alwaysOriginal))
        controller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)], for: .selected)
        
        let nav = UINavigationController(rootViewController: controller)
        self.addChild(nav)
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
