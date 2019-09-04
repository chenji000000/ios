//
//  CJAdvertisingCollectionViewCell.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import UIKit

class CJAdvertisingCollectionViewCell: UICollectionViewCell {
    let imgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        imgView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        self.contentView.addSubview(imgView)
    }
    
    var dataModel: CJAdvertisingModel? {
        didSet {
            loadContent()
        }
    }
    
    func loadContent() {
        imgView.sd_setImage(with: URL(string: dataModel!.cover!), placeholderImage: nil, options: .retryFailed, context: nil)
    }
    
}
