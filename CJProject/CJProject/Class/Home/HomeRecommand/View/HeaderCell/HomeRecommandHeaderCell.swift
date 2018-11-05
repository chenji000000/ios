//
//  HomeRecommandHeaderCell.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/26.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit
import FSPagerView

protocol HomeRecommandHeaderCellDelegate: NSObjectProtocol {
    func recommandHeaderBtnClick(categoryId: String, title: String, url: String)
    func recommandHeaderBannerClick(url: String)
}

class HomeRecommandHeaderCell: UICollectionViewCell {
    weak var delegate: HomeRecommandHeaderCellDelegate?
    
    private var focus: FocusModel?
    private var square: [SquareModel]?
    private var topBuzzList: [TopBuzzModel]?
    
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval = 3
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 15
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        return pagerView
    }()
    
    private lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(HomeRecommandGridCell.self, forCellWithReuseIdentifier: "HomeRecommandGridCell")
        collectionView.register(RecommandNewsCell.self, forCellWithReuseIdentifier: "RecommandNewsCell")
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
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150)
        }
        self.addSubview(self.gridView)
        self.gridView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.pagerView.snp.bottom)
            make.height.equalTo(210)
        }
        self.pagerView.itemSize = CGSize(width: CJScreenWidth - 60, height: 140)
    }
    
    var focusModel: FocusModel? {
        didSet {
            guard let model = focusModel else {
                return
            }
            self.focus = model
            self.pagerView.reloadData()
        }
    }
    
    var squareList: [SquareModel]? {
        didSet {
            guard let model = squareList else {
                return
            }
            self.square = model
            self.gridView.reloadData()
        }
    }
    
    var topBuzzListData: [TopBuzzModel]? {
        didSet {
            guard let model = topBuzzListData else {
                return
            }
            self.topBuzzList = model
            self.gridView.reloadData()
        }
    }
}

extension HomeRecommandHeaderCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.focus?.data?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string: (self.focus?.data?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let url: String = self.focus?.data?[index].link ?? ""
        delegate?.recommandHeaderBannerClick(url: url)
    }
}


extension HomeRecommandHeaderCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.square?.count ?? 0
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: HomeRecommandGridCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeRecommandGridCell", for: indexPath) as! HomeRecommandGridCell
            cell.square = self.square?[indexPath.row]
            return cell
        } else {
            let cell: RecommandNewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandNewsCell", for: indexPath) as! RecommandNewsCell
            cell.topBuzzList = self.topBuzzList
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: (CJScreenWidth - 5)/5, height: 80)
        } else {
            return CGSize(width: CJScreenWidth, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let string = self.square?[indexPath.row].properties?.uri else {
            let categoryId: String = "0"
            let title: String = self.square?[indexPath.row].title ?? ""
            let url: String = self.square?[indexPath.row].url ?? ""
            delegate?.recommandHeaderBtnClick(categoryId: categoryId, title: title, url: url)
            return
        }
        let categoryId: String = getUrlCategoryId(url: string)
        let title: String = self.square?[indexPath.row].title ?? ""
        let url: String = self.square?[indexPath.row].url ?? ""
        delegate?.recommandHeaderBtnClick(categoryId: categoryId, title: title, url: url)
    }
    
    func getUrlCategoryId(url: String) -> String {
        if !url.contains("?") {
            return ""
        }
        var params = [String: Any]()
        let split = url.split(separator: "?")
        let string = split[1]
        if string.contains("&") {
            let urlComponents = string.split(separator: "&")
            for keyValuePair in urlComponents {
                let pairComponents = keyValuePair.split(separator: "=")
                let key: String = String(pairComponents[0])
                let value: String = String(pairComponents[1])
                params[key] = value
            }
        } else {
            let pairComponents = string.split(separator: "=")
            if pairComponents.count == 1 {
                return "nil"
            }
            let key: String = String(pairComponents[0])
            let value: String = String(pairComponents[1])
            params[key] = value
        }
        return params["category_id"] as! String
    }
}
