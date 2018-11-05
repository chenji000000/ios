//
//  HomeOneKeyListenCell.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/26.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit

class HomeOneKeyListenCell: UICollectionViewCell {
    private var oneKeyListen: [OneKeyListenModel]?
    private lazy var changeBtn: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(UIColor.dominantColor, for: .normal)
        button.backgroundColor = UIColor.mainColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(updateBtnClick(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (CJScreenWidth - 45)/3, height: 120)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(OneKeyListenCell.self, forCellWithReuseIdentifier: "OneKeyListenCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        self.addSubview(self.gridView)
        self.gridView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func updateBtnClick(_ button: UIButton) {
        
    }
    
    var oneKeyListenList: [OneKeyListenModel]? {
        didSet {
            guard let model = oneKeyListenList else {
                return
            }
            self.oneKeyListen = model
            self.gridView.reloadData()
        }
    }
}

extension HomeOneKeyListenCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.oneKeyListen?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OneKeyListenCell", for: indexPath) as! OneKeyListenCell
        cell.oneKeyListen = self.oneKeyListen?[indexPath.row]
        return cell
    }
}
