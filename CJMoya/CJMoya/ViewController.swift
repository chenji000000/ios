//
//  ViewController.swift
//  CJMoya
//
//  Created by 陈吉 on 2018/10/10.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var channelModel: ChannelModel?

    fileprivate func configView() {
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        self.view.addSubview(self.tableView)
    }
    
    fileprivate func loadData() {
        DouBanProvider.request(.channels) { (result) in
            if case let .success(response) = result {
                
                self.channelModel = response.data.toModel(modelType: ChannelModel.self)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        loadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelModel?.channels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify: String = "SwiftCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = channelModel?.channels[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelName = channelModel?.channels[indexPath.row].name
        let channelId = channelModel?.channels[indexPath.row].channelId
        
        DouBanProvider.request(.playlist(channelId ?? "0")) { (result) in
            if case let .success(response) = result {
                let playlist = response.data.toModel(modelType: PlaylistModel.self)
                let music = playlist?.song[0]
                let artist = music?.artist ?? ""
                let title = music?.title ?? ""
                let message = "歌手：\(String(describing: artist))\n 歌曲：\(String(describing: title))"
                
                self.showAlert(title: channelName ?? "未知", message: message)
            }
        }
        
    }
    
    func showAlert(title: String, message: String) {
        let alertContrller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertContrller.addAction(cancelAction)
        self.present(alertContrller, animated: true, completion: nil)
    }


}

