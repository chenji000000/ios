//
//  CJMyMainViewController.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import UIKit

class CJMyMainViewController: UIViewController {
    
    var tableView: UITableView?
    let dataArr = ["学分查询", "意见反馈", "积分商城", "我的收藏", "系统设置"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI() {
        title = "我的"
        view.backgroundColor = UIColor.white
        
        tableView = UITableView(frame: CGRect(x: 0, y: Top_Height, width: ScreenWidth, height: ScreenHeight - Top_Height - TabBar_Height), style: .plain)
        tableView?.backgroundColor = UIColor.white
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
        view.addSubview(tableView!)
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

extension CJMyMainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        if nil == cell {
            cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        }
        let imgName = (indexPath.row == 0) ? "huCreditQuery":(indexPath.row == 1) ? "huFeedBack": (indexPath.row == 2) ? "huIntegralMall": (indexPath.row == 3) ? "huMyCollection" : "huEmployeeSatisfaction"
        cell?.imageView?.image = UIImage(named: imgName)
        cell?.textLabel?.text = self.dataArr[indexPath.row]
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = CJSettingViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
}
