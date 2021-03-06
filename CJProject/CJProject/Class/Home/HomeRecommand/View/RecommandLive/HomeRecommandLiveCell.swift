//
//  HomeRecommandLiveCell.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/26.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeRecommandLiveCell: UICollectionViewCell {
    private var live: [LiveModel]?
    private let RecommandLiveCellID = "RecommandLiveCell"
    private lazy var changeBtn: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(UIColor.dominantColor, for: .normal)
        button.backgroundColor = UIColor.mainColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(updataBtnClick(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(RecommandLiveCell.self, forCellWithReuseIdentifier: RecommandLiveCellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var liveList: [LiveModel]? {
        didSet {
            guard let model = liveList else {
                return
            }
            self.live = model
            self.collectionView.reloadData()
        }
    }
    
    @objc func updataBtnClick(_ button: UIButton) {
        CJRecommandProvider.request(.changeLiveList) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<LiveModel>.deserializeModelArrayFrom(json: json["data"]["list"].description) {
                    self.live = mappedObject as? [LiveModel]
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension HomeRecommandLiveCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.live?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecommandLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommandLiveCellID, for: indexPath) as! RecommandLiveCell
        cell.recommandliveData = self.live?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5,left: 0,bottom: 5,right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (CJScreenWidth - 55)/3, height: 180)
    }
}
