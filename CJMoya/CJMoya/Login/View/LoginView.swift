//
//  LoginView.swift
//  CJMoya
//
//  Created by 陈吉 on 2018/10/12.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "请输入姓名"
        nameTextField.font = UIFont.systemFont(ofSize: 15)
        nameTextField.textColor = UIColor.black
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    }()
    var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.textColor = UIColor.black
        passwordTextField.borderStyle = .line
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()
    var loginBtn: UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        loginBtn.backgroundColor = UIColor.red
        loginBtn.setTitleColor(UIColor.black, for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .disabled)
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        return loginBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configView() {
        self.backgroundColor = UIColor.white
        self.addSubview(self.nameTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.loginBtn)
        
        nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        nameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
        
        loginBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50).isActive = true
        loginBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        loginBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
