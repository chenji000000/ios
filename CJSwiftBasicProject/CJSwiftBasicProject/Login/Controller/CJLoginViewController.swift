//
//  CJLoginViewController.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import UIKit

class CJLoginViewController: UIViewController {
    
    var backgroundImageView: UIImageView?
    
    let acountTextField = UITextField()
    let pswTextField = UITextField()
    let loginBnt = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI() {
        title = "登录"
        view.backgroundColor = UIColor.white
        
        backgroundImageView = UIImageView(frame: view.frame)
        backgroundImageView?.image = UIImage(named: "backgroundImage")
        backgroundImageView?.isUserInteractionEnabled = true
        view.addSubview(backgroundImageView!)
        
        //用户名输入框
        acountTextField.frame = CGRect(x: Common_Margin*2, y: Top_Height+50, width: (ScreenWidth-Common_Margin*4), height: 40)
        acountTextField.placeholder = "请输入手机号"
        acountTextField.text = "13738172768"
        acountTextField.layer.borderWidth = 0.6
        acountTextField.layer.borderColor = UIColor.gray.cgColor
        acountTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        acountTextField.leftViewMode = .always
        acountTextField.delegate = self
        backgroundImageView?.addSubview(acountTextField)
        
        //密码输入框
        pswTextField.frame = CGRect(x: acountTextField.left, y: acountTextField.bottom+30, width: acountTextField.width, height: acountTextField.height)
        pswTextField.placeholder = "请输入密码"
        pswTextField.text = "wy123456"
        pswTextField.layer.borderWidth = 0.6
        pswTextField.layer.borderColor = UIColor.gray.cgColor
        pswTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        pswTextField.leftViewMode = .always
        pswTextField.delegate = self
        backgroundImageView?.addSubview(pswTextField)
        
        //登录按钮
        loginBnt.frame = CGRect(x: acountTextField.left, y: pswTextField.bottom+30, width: acountTextField.width, height: acountTextField.height)
        loginBnt.backgroundColor = UIColor.blue
        loginBnt.setTitle("登录", for: .normal)
        loginBnt.setTitleColor(UIColor.white, for: .normal)
        loginBnt.layer.shadowOffset = CGSize(width: 0, height: 5)
        loginBnt.layer.shadowColor = UIColor.blue.cgColor
        loginBnt.layer.shadowOpacity = 0.5
        loginBnt.layer.cornerRadius = 5
        loginBnt.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        backgroundImageView?.addSubview(loginBnt)
    }
    
    //登录
    @objc func loginBtnClicked(){
        
        let param:[String:Any] = ["mobile":acountTextField.text!,
                                  "password":pswTextField.text!.md5(),
                                  ]
        showHUD()
        
        CJNetRequest.requestWith(method: .post, url: "http://uat.317hu.com/care-nurse/nurse/account/login/byPassword", param: param, token: nil) { (response) in
            
            hideHUD()
            
            if response.success {
                let json = response.json!
                let dic = json["data"].rawValue
                let model = CJLoginModel.mj_object(withKeyValues: dic)
                
                //存储登录信息
                UserDefaults.standard.set(model?.itsId, forKey: "NURSEID")
                UserDefaults.standard.set(model?.name, forKey: "NURSENAME")
                
                let tabbar = CJTabBarController()
                UIApplication.shared.delegate?.window??.rootViewController = tabbar
                
                print("登陆成功")
            }else{
                print("登陆失败")
            }
        }
        
    }
    
    //取消第一响应
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.acountTextField.resignFirstResponder()
        self.pswTextField.resignFirstResponder()
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

extension CJLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.acountTextField {
            self.acountTextField.resignFirstResponder()
            self.pswTextField.becomeFirstResponder()
        } else {
            self.pswTextField.resignFirstResponder()
        }
        return true
    }
}
