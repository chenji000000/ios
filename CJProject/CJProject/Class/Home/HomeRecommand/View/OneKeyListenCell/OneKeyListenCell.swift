//
//  OneKeyListenCell.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/26.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit

class OneKeyListenCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(70)
            make.centerX.equalToSuperview()
            make.top.equalTo(15)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var oneKeyListen: OneKeyListenModel? {
        didSet {
            guard let model = oneKeyListen else {
                return
            }
            if model.coverRound != nil {
                self.imageView.kf.setImage(with: URL(string: model.coverRound!))
            }
            self.titleLabel.text = model.channelName
        }
    }
}
