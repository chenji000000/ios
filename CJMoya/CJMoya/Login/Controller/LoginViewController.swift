//
//  LoginViewController.swift
//  CJMoya
//
//  Created by 陈吉 on 2018/10/12.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let minimalUsernameLength = 6

class LoginViewController: UIViewController {
    
    var loginView: LoginView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configView()
    }
    
    fileprivate func configView() {
        self.loginView = LoginView(frame: self.view.frame)
        self.view.addSubview(self.loginView)
        bindLoginView()
    }
    
    fileprivate func bindLoginView() {
        let nameValid = loginView.nameTextField.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay:1)
        let passwordValid = loginView.passwordTextField.rx.text.orEmpty
            .map{ $0.count >= minimalUsernameLength }
            .share(replay:1)
        let everythingValid = Observable.combineLatest(nameValid, passwordValid) { $0 && $1 }
            .share(replay:1)
        
        nameValid
            .bind(to: loginView.passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: loginView.loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginView.loginBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showAlert()
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func showAlert() {
        print("showAlert")
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
