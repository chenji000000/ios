//
//  CJSettingViewController.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import UIKit

class CJSettingViewController: UIViewController {
    
    let logoutBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.5) {
            self.logoutBtn.frame = CGRect(x: Common_Margin, y: (ScreenHeight - 50)/2, width: ScreenWidth - Common_Margin * 2, height: 50)
            self.logoutBtn.alpha = 1
        }
    }
    
    func setUI() {
        view.backgroundColor = UIColor.white
        title = "设置"
        
        logoutBtn.frame = CGRect(x: -ScreenWidth, y: (ScreenHeight-50)/2, width: ScreenWidth-Common_Margin*2, height: 50)
        logoutBtn.setTitle("退出", for: .normal)
        logoutBtn.setTitleColor(UIColor.red, for: .normal)
        logoutBtn.backgroundColor = UIColor.cyan
        logoutBtn.alpha = 0;
        logoutBtn.addTarget(self, action: #selector(logoutBtnClicked), for: .touchUpInside)
        view.addSubview(logoutBtn)
    }
    
    @objc func logoutBtnClicked(){
        showHUD()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            hideHUD()
            
            UserDefaults.standard.removeObject(forKey: "NURSEID")
            UserDefaults.standard.removeObject(forKey: "NURSENAME")
            
            UIApplication.shared.delegate?.window??.rootViewController = CJLoginViewController()
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
