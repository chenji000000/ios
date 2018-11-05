//
//  HomeHotAudioBookCell.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/26.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit

protocol HomeHotAudioBookCellDelegate: NSObjectProtocol {
    func hotAudiobookCellItemClick(model: RecommendListModel)
}

class HomeHotAudioBookCell: UICollectionViewCell {
    weak var delegate: HomeHotAudioBookCellDelegate?
    private var recommandList: [RecommendListModel]?
    private let HotAudiobookCellId = "HotAudiobookCell"
    private lazy var changeBtn: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(UIColor.dominantColor, for: .normal)
        button.backgroundColor = UIColor.mainColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(HotAudioBookCell.self, forCellWithReuseIdentifier: HotAudiobookCellId)
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
    
    var recommandListData: [RecommendListModel]? {
        didSet {
            guard let model = recommandListData else {
                return
            }
            self.recommandList = model
            self.collectionView.reloadData()
        }
    }
}

extension HomeHotAudioBookCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommandList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HotAudioBookCell = collectionView.dequeueReusableCell(withReuseIdentifier: HotAudiobookCellId, for: indexPath) as! HotAudioBookCell
        cell.recommandData = self.recommandList?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.hotAudiobookCellItemClick(model: (self.recommandList?[indexPath.row])!)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CJScreenWidth - 30, height: 120)
    }
    
}
