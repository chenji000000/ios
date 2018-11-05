//
//  RecommandGuessYouLikeCell.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/26.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit

class RecommandGuessYouLikeCell: UICollectionViewCell {
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    private var subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
    
    var recommandData: RecommendListModel? {
        didSet {
            guard let model = recommandData else {
                return
            }
            if model.pic != nil {
                self.imageView.kf.setImage(with: URL(string: model.pic!))
            }
            self.titleLabel.text = model.title
            self.subLabel.text = model.subtitle
        }
        
    }
}
