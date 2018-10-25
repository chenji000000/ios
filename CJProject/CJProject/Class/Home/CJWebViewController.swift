//
//  CJWebViewController.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/24.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit
import WebKit

class CJWebViewController: UIViewController {
    
    private var url: String = ""
    
    convenience init(url: String = "") {
        self.init()
        self.url = url
    }
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: self.view.bounds)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        webView.load(URLRequest(url: URL(string: self.url)!))
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
