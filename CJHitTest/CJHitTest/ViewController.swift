//
//  ViewController.swift
//  CJHitTest
//
//  Created by 陈吉 on 2018/10/11.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configView()
    }

    fileprivate func configView() {
        let viewB = HitView()
        viewB.identifier = "viewB"
        viewB.backgroundColor = UIColor.yellow
        viewB.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewB)
        
        let viewBLeft = viewB.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let viewBTop = viewB.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        let viewBRight = viewB.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        let viewBHeight = viewB.heightAnchor.constraint(equalToConstant: 200)
        
        viewBLeft.isActive = true
        viewBTop.isActive = true
        viewBRight.isActive = true
        viewBHeight.isActive = true
        
        let viewC = HitView()
        viewC.identifier = "viewC"
        viewC.backgroundColor = UIColor.red
        viewC.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewC)
        
        let viewCLeft = viewC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let viewCTop = viewC.topAnchor.constraint(equalTo: viewB.bottomAnchor, constant: 20)
        let viewCRight = viewC.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        let viewCBottom = viewC.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        
        viewCLeft.isActive = true
        viewCTop.isActive = true
        viewCRight.isActive = true
        viewCBottom.isActive = true
        
        let viewD = HitView()
        viewD.identifier = "viewD"
        viewD.backgroundColor = UIColor.green
        viewD.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewD)
        
        let viewDLeft = viewD.leadingAnchor.constraint(equalTo: viewC.leadingAnchor, constant: 20)
        let viewDTop = viewD.topAnchor.constraint(equalTo: viewC.topAnchor, constant: 20)
        let viewDRight = viewD.trailingAnchor.constraint(equalTo: viewC.trailingAnchor, constant: -20)
        let viewDHeight = viewD.heightAnchor.constraint(equalToConstant: 100)
        
        viewDLeft.isActive = true
        viewDTop.isActive = true
        viewDRight.isActive = true
        viewDHeight.isActive = true
        
        let viewE = HitView()
        viewE.identifier = "viewE"
        viewE.backgroundColor = UIColor.blue
        viewE.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewE)
        
        let viewELeft = viewE.leadingAnchor.constraint(equalTo: viewC.leadingAnchor, constant: 20)
        let viewETop = viewE.topAnchor.constraint(equalTo: viewD.bottomAnchor, constant: 20)
        let viewERight = viewE.trailingAnchor.constraint(equalTo: viewC.trailingAnchor, constant: -20)
        let viewEBottom = viewE.bottomAnchor.constraint(equalTo: viewC.bottomAnchor, constant: -20)
        
        viewELeft.isActive = true
        viewETop.isActive = true
        viewERight.isActive = true
        viewEBottom.isActive = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("A_touchesBegan")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("A_touchesMoved")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("A_touchesEnded")
    }

}

