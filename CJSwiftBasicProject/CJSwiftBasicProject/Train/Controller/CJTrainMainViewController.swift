//
//  CJTrainMainViewController.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import UIKit

class CJTrainMainViewController: UIViewController {
    
    let tableView = UITableView()
    let headerView = CJDesHospitalHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ItemHeight))
    
    var imgDataArr: [CJAdvertisingModel]?
    var tabDataArr = [CJDescovHospitalListModel]()
    
    // 创建调度组
    let group = DispatchGroup()
    // 创建队列
    let groupQueue = DispatchQueue(label: "chenji")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
        loadNetData()
    }
    
    func setUI() {
        title = "培训"
        self.view.backgroundColor = UIColor.white
        
        tableView.frame = CGRect(x: 0, y: Top_Height, width: ScreenWidth, height: ScreenHeight - Top_Height - TabBar_Height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.register(CJDescovHospitalTableViewCell.self, forCellReuseIdentifier: "CJDescovHospitalTableViewCell")
        view.addSubview(tableView)
    }
    
    func loadNetData() {
        // 入组
        group.enter()
        // 异步网络请求
        groupQueue.async {
            self.loadADData()
        }
        
        group.enter()
        groupQueue.async {
            self.loadHOSData()
        }
        
        // 调度组里的人物都执行完毕，主线程更新
        group.notify(queue: DispatchQueue.main) {
            self.headerView.imgDataArr = self.imgDataArr
            self.tableView.tableHeaderView = self.headerView
            self.tableView.reloadData()
        }
    }
    
    func loadADData() {
        let param = ["nurseId":"0"]
        CJNetRequest.requestWith(method: .get, url: "http://uat.317hu.com/care-nurse/hospital/adInfo/317", param: param, token: nil) { (response) in
            
            // 出组
            self.group.leave()
            
            if response.success{
                
                let json = response.json!
                let arr = json["data"].rawValue
                //返回的是OC类型数组
                let list = (CJAdvertisingModel.mj_objectArray(withKeyValuesArray: arr))
                
                if list != nil {
                    //转为Swift类型数组
                    self.imgDataArr = list! as NSArray as? [CJAdvertisingModel]
                }
                
                for model in self.imgDataArr!{
                    
                    model.cover = "http://image.317hu.com/"+model.imageId!
                }
            }
        }
    }
    
    func loadHOSData() {
        CJNetRequest.requestWith(method: .get, url: "https://nursetrainuat.317hu.com/nurse-train-web/nursetrain/app/expertTeam/v2.6.1.1/expertByExpertType/2", param: nil, token: nil) { (response) in
            
            // 出组
            self.group.leave()
            
            if response.success{
                
                let json = response.json!
                let arr = json["data"].rawValue
                let list = CJDescovHospitalListModel.mj_objectArray(withKeyValuesArray: arr)
                if list != nil{
                    
                    let array = list! as NSArray as? [CJDescovHospitalListModel]
                    //数组拼接,即把array中的元素添加到tabDataArr中
                    self.tabDataArr += array!
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

extension CJTrainMainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tabDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CJDescovHospitalTableViewCell", for: indexPath) as! CJDescovHospitalTableViewCell
        cell.model = tabDataArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
