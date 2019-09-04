//
//  CJDescovHospitalTableViewCell.swift
//  CJSwiftBasicProject
//
//  Created by 陈吉 on 2019/8/27.
//  Copyright © 2019 陈吉. All rights reserved.
//

import UIKit

class CJDescovHospitalTableViewCell: UITableViewCell {
    
    let imgView = UIImageView()
    let titleLab = UILabel()
    let subLab = UILabel()
    
    var model: CJDescovHospitalListModel? {
        didSet {
            loadContent()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        imgView.frame = CGRect(x: Common_Margin, y: 10, width: 50, height: 50)
        self.contentView.addSubview(imgView)
        
        titleLab.frame = CGRect(x: imgView.right+10, y: imgView.top, width: self.width-imgView.right-10, height: 30)
        titleLab.textColor = UIColor.black
        titleLab.font = UIFont.systemFont(ofSize: 18)
        titleLab.textAlignment = .left
        self.contentView.addSubview(titleLab)
        
        subLab.frame = CGRect(x: imgView.right+10, y: titleLab.bottom, width: self.width-imgView.right-10, height: 20)
        subLab.textColor = UIColor.lightGray
        subLab.font = UIFont.systemFont(ofSize: 16)
        subLab.textAlignment = .left
        self.contentView.addSubview(subLab)
    }
    
    func loadContent() {
        imgView.sd_setImage(with: URL(string: model!.headPortrait!), placeholderImage: nil, options: .retryFailed, completed: nil)
        titleLab.text = model?.name!
        
        let subStr = String(model!.courseCnt)
        let str = String(model!.courseCnt) + "篇课程"
        let arrStr = NSMutableAttributedString.init(string: str)
        arrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: subStr.count))
        subLab.attributedText = arrStr
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
