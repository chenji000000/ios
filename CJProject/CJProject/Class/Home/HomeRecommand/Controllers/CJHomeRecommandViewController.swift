//
//  CJHomeRecommandViewController.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/24.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

//首页推荐控制器
class CJHomeRecommandViewController: CJHomeBaseViewController {
    
    //MARK-数据模型
    private var recommandAdvertList: [RecommnedAdvertModel]? //穿插的广告数据
    private let HomeRecommandHeaderViewID = "HomeRecommandHeaderView"
    private let HomeRecommandFooterViewID = "HomeRecommandFooterView"
    
    private let HomeRecommandHeaderCellID = "HomeRecommandHeaderCell"
    private let HomeRecommandGuessLikeCellID = "HomeRecommandGuessLikeCell"
    private let HomeHotAudiobookCellID = "HomeHotAudiobookCell"
    private let HomeAdvertCellID = "HomeAdvertCell"
    private let HomeOneKeyListenCellID = "HomeOneKeyListenCell"
    private let HomeRecommandForYouCellID = "HomeRecommandForYouCell"
    private let HomeRecommandLiveCellID = "HomeRecommandLiveCell"

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        //注册头视图和尾视图
        collectionView.register(HomeRecommandHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeRecommandHeaderViewID)
        collectionView.register(HomeRecommandFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeRecommandFooterViewID)
        
        //不同cell
        collectionView.register(HomeRecommandHeaderCell.self, forCellWithReuseIdentifier: HomeRecommandHeaderCellID)
        collectionView.register(HomeRecommandGuessYouLikeCell.self, forCellWithReuseIdentifier: HomeRecommandGuessLikeCellID)
        collectionView.register(HomeHotAudioBookCell.self, forCellWithReuseIdentifier: HomeHotAudiobookCellID)
        collectionView.register(HomeAdvertCell.self, forCellWithReuseIdentifier: HomeAdvertCellID)
        collectionView.register(HomeOneKeyListenCell.self, forCellWithReuseIdentifier: HomeOneKeyListenCellID)
        collectionView.register(HomeRecommandForYouCell.self, forCellWithReuseIdentifier: HomeRecommandForYouCellID)
        collectionView.register(HomeRecommandLiveCell.self, forCellWithReuseIdentifier: HomeRecommandLiveCellID)
        collectionView.uHead = URefreshHeader { [weak self] in self?.loadData() }
        return collectionView
    }()
    
    lazy var viewModel: CJHomeRecommandViewModel = {
        return CJHomeRecommandViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        self.collectionView.uHead.beginRefreshing()
        loadData()
        loadRecommandAdData()
    }
    
    private func loadData() {
        viewModel.updateBlock = { [unowned self] in
            self.collectionView.uHead.endRefreshing()
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
    private func loadRecommandAdData() {
        //首页穿插广告接口请求
        CJRecommandProvider.request(.recommandAdList) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let advertList = JSONDeserializer<RecommnedAdvertModel>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.recommandAdvertList = advertList as? [RecommnedAdvertModel]
                    self.collectionView.reloadData()
                }
            }
        }
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

extension CJHomeRecommandViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView:collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = viewModel.homeRecommandList?[indexPath.section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" {
            let cell: HomeRecommandHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommandHeaderCellID, for: indexPath) as! HomeRecommandHeaderCell
            cell.focusModel = viewModel.focus
            cell.squareList = viewModel.squareList
            cell.topBuzzListData = viewModel.topBuzzList
            cell.delegate = self
            return cell
        } else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" {
            let cell: HomeRecommandGuessYouLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommandGuessLikeCellID, for: indexPath) as! HomeRecommandGuessYouLikeCell
            cell.delegate = self
            cell.recommandListData = viewModel.homeRecommandList?[indexPath.section].list
            return cell
        } else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore" {
            let cell: HomeHotAudioBookCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHotAudiobookCellID, for: indexPath) as! HomeHotAudioBookCell
            cell.delegate = self
            cell.recommandListData = viewModel.homeRecommandList?[indexPath.section].list
            return cell
        } else if moduleType == "ad" {
            let cell: HomeAdvertCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeAdvertCellID, for: indexPath) as! HomeAdvertCell
            if indexPath.section == 7 {
                cell.adModel = self.recommandAdvertList?[0]
            } else if indexPath.section == 13 {
                cell.adModel = self.recommandAdvertList?[1]
            }
            return cell
        } else if moduleType == "oneKeyListen" {
            let cell: HomeOneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeOneKeyListenCellID, for: indexPath) as! HomeOneKeyListenCell
            cell.oneKeyListenList = viewModel.oneKeyListenList
            return cell
        } else if moduleType == "live" {
            let cell: HomeRecommandLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommandLiveCellID, for: indexPath) as! HomeRecommandLiveCell
            cell.liveList = viewModel.liveList
            return cell
        } else {
            let cell: HomeRecommandForYouCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommandForYouCellID, for: indexPath) as! HomeRecommandForYouCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insertForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let moduleType = viewModel.homeRecommandList?[indexPath.section].moduleType
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: HomeRecommandHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeRecommandHeaderViewID, for: indexPath) as! HomeRecommandHeaderView
            headerView.homeRecommentList = viewModel.homeRecommandList?[indexPath.section]
            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footerView: HomeRecommandFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeRecommandFooterViewID, for: indexPath) as! HomeRecommandFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}

extension CJHomeRecommandViewController: HomeRecommandHeaderCellDelegate {
    func recommandHeaderBannerClick(url: String) {
        print("------\(url)")
    }
    
    func recommandHeaderBtnClick(categoryId: String, title: String, url: String) {
        print("-------\(categoryId)-------\(title)-------\(url)")
    }
}


extension CJHomeRecommandViewController: HomeRecommandGuessYouLikeCellDelegate {
    func recommandGuessYouLikeCellItemClick(model: RecommendListModel) {
        print("-------\(model.albumId)")
    }
}

extension CJHomeRecommandViewController: HomeHotAudioBookCellDelegate {
    func hotAudiobookCellItemClick(model: RecommendListModel) {
        print("-------\(model.albumId)")
    }
}
