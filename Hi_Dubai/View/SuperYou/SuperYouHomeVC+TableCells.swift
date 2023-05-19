//
//  SuperYouHomeVC+TableCells.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//


import UIKit
//import PushKit

//MARK:- Extensions UITableView Delegate DataSource

extension SuperYouHomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.shimmerStatus {
        case .toBeApply:
            return 3
        case .applied:
            if let superYouData = self.viewModel.superYouData {
                return superYouData.tableCellAtIndexPath.count
            }
            return 0
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.shimmerStatus {
        case .toBeApply:

            return 1
        case .applied:
            if let superYouData = self.viewModel.superYouData {
                return superYouData.tableCellAtIndexPath[section].count
            }
            return 0
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.shimmerStatus {

        case .toBeApply:
            switch indexPath.section {
            case 0:
                return self.getTitleCell(tableView, indexPath: indexPath, dataSource: SuperYouHomeTitleData())
            case 1:
                return self.getCardCell(tableView, indexPath: indexPath, dataSource: SuperYouCardData())
            case 2:
                return self.getVideoCell(tableView, indexPath: indexPath, dataSource: SuperYouVideoData())

            default:
                return self.getUpcomingCell(tableView, indexPath: indexPath, dataSource: SuperYouHomeModel(nextPageStatus: true))
            }

        case .applied:
        
            if let superYouData = self.viewModel.superYouData {
                
//                if self.viewModel.nextPageStatus && superYouData.tableCellAtIndexPath.count - 1 == indexPath.section && self.viewModel.apiHitCount == 1 {
//                    self.viewModel.getSuperMeData(isPullToRefresh: false)
//                }
                
                switch superYouData.tableCellAtIndexPath[indexPath.section][indexPath.row] {
                    
                case .titleAndSubTitle:
                    return self.getTitleCell(tableView, indexPath: indexPath, dataSource: superYouData.titleData ?? SuperYouHomeTitleData())
                    
                case .cardCells:
                    return self.getCardCell(tableView, indexPath: indexPath, dataSource: superYouData.cardData ?? SuperYouCardData())
                    
                case .videoCell:
                    return self.getVideoCell(tableView, indexPath: indexPath, dataSource: superYouData.videoData ?? SuperYouVideoData())
                    
                case .upcomingCell:
                    return self.getUpcomingCell(tableView, indexPath: indexPath, dataSource: superYouData)
                    
                case .liveClassesCell:
                    return self.getLiveNowCell(tableView, indexPath: indexPath, dataSource: superYouData)
                    
                case .favoritesCell:
                    return self.getFavouriteCell(tableView, indexPath: indexPath, dataSource: superYouData)

                case .mostLovedClassesCell:
                    return self.getMostLovedClassesCell(tableView, indexPath: indexPath, dataSource: superYouData)
                    
                case .newSuperShesCell:
                    return self.getNewSuperShesCell(tableView, indexPath: indexPath, dataSource: superYouData)
                    
                case .featuredCell:
                    return self.getFeaturedCell(tableView, indexPath: indexPath, dataSource: superYouData)
                    
                case .categories:
                    return self.getCategoriesCell(tableView, indexPath: indexPath,dataSource: superYouData )
                    
                case .pastLive:
                    return self.getpastLiveClassesCell(tableView, indexPath: indexPath, dataSource: superYouData)
                    
                case .superPowers:
                    return self.getCategoriesCell(tableView, indexPath: indexPath, dataSource: superYouData)
                }
            } else {
                return UITableViewCell()
            }
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard self.shimmerStatus == .applied else { return }
        (cell as? SuperViewCardTableViewCell)?.cardCollectionView.contentOffset.x = self.collectionViewCachedPosition[indexPath] ?? 0.0

        self.cellHeightDictionary.setObject(cell.frame.size.height, forKey: indexPath as NSCopying)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard self.shimmerStatus == .applied else { return }
        self.collectionViewCachedPosition[indexPath] = (cell as? SuperViewCardTableViewCell)?.cardCollectionView.contentOffset.x
//        if indexPath.section == 2 , let currentCell = cell as? SuperYouVideoTableViewCell {
////            currentCell.player?.pause()
//            DispatchQueue.main.async {
//                currentCell.player?.pause()
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let superYouData = self.viewModel.superYouData {
            
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TalksHomeTableHeader") as? TalksHomeTableHeader {
                print("\(superYouData.tableCellAtIndexPath[section][0])")
                switch superYouData.tableCellAtIndexPath[section][0] {
                    
                case .titleAndSubTitle:
                    headerView.headerViewSetUpForSuperYou(title: "Upcoming", toShowSeeAll: superYouData.upcomingDataArr.count > 2)
                    
                case .cardCells:
                    headerView.headerViewSetUpForSuperYou(title: "Card Cell", toShowSeeAll: superYouData.upcomingDataArr.count > 2)
                    
                case .videoCell:
                    headerView.headerViewSetUpForSuperYou(title: "Video Cell", toShowSeeAll: superYouData.upcomingDataArr.count > 2)
                    
                case .upcomingCell:
                    headerView.headerViewSetUpForSuperYou(title: "Upcoming Deals", toShowSeeAll: superYouData.upcomingDataArr.count > 2)
                    return headerView
                    
                case .liveClassesCell:
                    headerView.headerViewSetUpForSuperYou(title: "Super She LiveNow", toShowSeeAll: superYouData.liveNowDataArr.count >= 2)
                    return headerView
                    
                case .favoritesCell:
                    headerView.headerViewSetUpForSuperYou(title: "newFromMyFriends", toShowSeeAll: superYouData.favouriteDataArr.count > 3)
                    return headerView
                case .mostLovedClassesCell:
                    headerView.headerViewSetUpForSuperYou(title: "Most Loved Vids This Week", toShowSeeAll: superYouData.mostLovedArr.count > 2)
                    return headerView
                case .newSuperShesCell:
                    headerView.headerViewAttributedSetUpForSuperYou(title: "New Super She", subtitle: "Find awesome SuperShes to follow here", toShowSeeAll: false)
                    return headerView
                case .featuredCell:
                    headerView.headerViewAttributedSetUpForSuperYou(title: "Featured VIDs", subtitle: "Find awesome SuperShes to follow here", toShowSeeAll: false)
                    return headerView
                case .superPowers:
                    return nil
                case .pastLive:
                    headerView.headerViewSetUpForSuperYou(title: "Past Live Vids", toShowSeeAll: superYouData.pastLiveData.count > 2)
                    return headerView
                case .categories:
                    headerView.headerViewSetUpForSuperYou(title: "Categories", toShowSeeAll: superYouData.categories.count > 2)
                    return headerView
                }
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if let superYouData = self.viewModel.superYouData //self.shimmerStatus == .applied {
        {
            switch superYouData.tableCellAtIndexPath[section][0] {
            case .favoritesCell:
                return 50.0
            case .upcomingCell, .pastLive, .liveClassesCell,.featuredCell:
                return 50.0
            case .mostLovedClassesCell:
                return 50.0
            case .newSuperShesCell:
                return 50.0
            case .categories:
                return 50.0
            default: return CGFloat.leastNonzeroMagnitude
            }
        }
        return CGFloat.leastNonzeroMagnitude
    }
    
//    self.tableCellAtIndexPath.append([.mostLovedClassesCell])
//    self.tableCellAtIndexPath.append([.upcomingCell])
//    self.tableCellAtIndexPath.append([.liveClassesCell])
//    self.tableCellAtIndexPath.append([.featuredCell])
//    self.tableCellAtIndexPath.append([.newSuperShesCell])
//    self.tableCellAtIndexPath.append([.favoritesCell])
//    self.tableCellAtIndexPath.append([.pastLive])
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        print(indexPath)
        if cellHeightDictionary.object(forKey: indexPath) != nil, let height = cellHeightDictionary.object(forKey: indexPath) as? CGFloat {
            return height
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch self.shimmerStatus {
        case .toBeApply:
            switch indexPath.section {
            case 0,1:
                return UITableView.automaticDimension
            default:
                //return ClassInitalLayoutConstants.collUpcomingCellHeight
                return screen_height * 0.7
            }

        case .applied:
            if let superYouData = self.viewModel.superYouData {
                switch superYouData.tableCellAtIndexPath[indexPath.section][indexPath.row] {

                case .videoCell:
                    if let height = superYouData.videoData?.height, let width = superYouData.videoData?.width {
                        let aspectRatio = CGFloat(height) / CGFloat(width)
                        if (screen_width * aspectRatio) > screen_height * 0.7 {
                            return screen_height * 0.75//screenHeight - self.statusBarHeight - self.tabBarHeight
                        }
                        return (screen_width * aspectRatio).isNaN ? 0.0 : (screen_width * aspectRatio)
                    }
                    return 220.0
                case .upcomingCell:
                    return 220.0
                case .liveClassesCell:
                    return TalksTablePropertyHeight.tableFooter
                case .pastLive:
                    return TalksTablePropertyHeight.discussedCellHeight
                case .favoritesCell:
                    return 220.0
                case .mostLovedClassesCell:
                    return 220.0
                case .newSuperShesCell:
                    return CGFloat(0.30 * screen_height)
                case .featuredCell:
                    return TalksTablePropertyHeight.featuredHomeCellHeight
                default:
                    return UITableView.automaticDimension
                }
            }
            return 220.0
        case .none:
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section > 1 {
//            return 34.0//72.0
//        }
        return CGFloat.leastNonzeroMagnitude
    }
}

extension SuperYouHomeVC: SuperYouHomeVMDelegate {
    
    func willHitSuperYouApi() {
        
    }
    
    func getSuperYouDataSuccess(successMsg: String, isPullToRefresh: Bool, lastPageScrolled: Int) {

//        if self.viewModel.apiHitCount == 1 {
//            self.viewModel.getSuperMeData(isPullToRefresh: false)
//        }
//
//        if self.shimmerStatus == .toBeApply {
//            self.shimmerStatus = .applied
//            isRemoveImgBg = true
//            self.dataTableView.removeShimmerFromTableView(isCollVwInContentView: true)
//        }
//        self.dataTableView.restore()
//        if !isPullToRefresh {
//            self.navBar.imageViewSetUp(withDuration: self.isDataInitializeFromCache ? 0.0 : 1.5, imageUrl: UserModel.main.profilePicture)
//        } else {
//            self.shimmerStatus = .applied
//            self.cellHeightDictionary.removeAllObjects()
////            self.dataTableView.refresh.endRefreshing()
////            self.dataTableView.layoutIfNeeded()
//        }
        self.dataTableView.reloadData()
//        checkFirstTime = false
//        if !self.newPostBtn.isHidden {
//            self.newPostBtn.stopActivityLoader(title: "New Post")
//            self.newPostBtnAnimationSetUp(isStart: false)
//        }
    }
    
//    func getSuperYouDataFailed(failedToGetData: String, isPullToRefresh: Bool,errorType: ErrorType) {
//
//        if self.shimmerStatus == .toBeApply {
//            self.shimmerStatus = .applied
//            isRemoveImgBg = true
//            self.dataTableView.removeShimmerFromTableView(isCollVwInContentView: true)
//        }
//        if (JSON(localData as Any).isEmpty) , self.viewModel.superYouData == nil  {
//
//            self.dataTableView.setEmptyMessage(failedToGetData, retry: true, retryAction: {[weak self] in
//
//                self?.shimmerStatus = .toBeApply
//                self?.dataTableView.alpha = 1.0
//                self?.dataTableView.reloadData()
//                self?.view.layoutIfNeeded()
//                self?.showShimmerAndHitApi()
//                }, errorType : errorType)
//
//        } else {
//            self.dataTableView.restore()
//        }
//
//
//        if !isPullToRefresh {
//            self.navBar.imageViewSetUp(withDuration: self.isDataInitializeFromCache ? 0.0 : 1.5, imageUrl:  UserModel.main.profilePicture)
//            if (failedToGetData != "cancelled") {
//                showToast(failedToGetData, position: .top)
//            }
//        } else {
//            self.shimmerStatus = .applied
////            self.dataTableView.refresh.endRefreshing()
////            self.dataTableView.layoutIfNeeded()
//        }
//
//        self.dataTableView.reloadData()
//        checkFirstTime = false
//        if !self.newPostBtn.isHidden {
//            self.newPostBtn.stopActivityLoader(title: "New Post")
//            self.newPostBtnAnimationSetUp(isStart: false)
//        }
//    }
    
    
    func endPullTorefreshRequest(lastPageScrolled: Int) {
        
        
//        guard let tableCellAtIndexPath = self.viewModel.superYouData?.tableCellAtIndexPath else { return }
//
//        let startIndex = tableCellAtIndexPath.count - lastPageScrolled
//        let endIndex = startIndex + lastPageScrolled - 1
//        let newIndexPaths = (startIndex...endIndex).map { i in
//            return IndexPath(row: 0, section: i)
//        }
//        let visibleIndexPaths = Set(
//            self.dataTableView.indexPathsForVisibleRows ?? [])
//        let indexPathsNeedingReload = Set(newIndexPaths)
//            .intersection(visibleIndexPaths)
//        self.dataTableView.reloadRows(at: Array(indexPathsNeedingReload),
//                                  with: .fade)
    }
    
//    func updateDeviceTokenSuccess(successMsg: String) {
//        printDebug(successMsg)
//        if DeviceDetail.voipToken == "DummyVoipToken", !UserModel.main.id.isEmpty {
//            AppDelegate.shared.pushKitRegistration()
////            self.viewModel.updateVoipToken()
//        }
//    }
    
//    func updateDeviceTokenFailed(failedToGetData: String) {
//        printDebug(failedToGetData)
//        if DeviceDetail.voipToken == "DummyVoipToken", !UserModel.main.id.isEmpty {
//             AppDelegate.shared.pushKitRegistration()
////            self.viewModel.updateVoipToken()
//        }
//    }
}

extension SuperYouHomeVC {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navContainerView.didScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.navContainerView.didEndScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.navContainerView.didEndScrolling(decelerate)
    }
}



struct TalksTablePropertyHeight {
    
    static var mainCell = CGFloat(185) // CGFloat((185/812) * Screen.HEIGHT) + 18
    static var tableFooter = CGFloat((244/812) * screen_height)
    static var tableHeader = CGFloat((450/812) * screen_height) - 18
    static var featuredHomeCellHeight = screen_height * 0.35
    static var talkTableHeader = CGFloat((570/812) * screen_height)
    static var sectionHeader = CGFloat((104/812) * screen_height)
    static var sectionFooter = CGFloat((50/812) * screen_height) + 40 //Extra space
    static var tableFooterWidth = CGFloat((147/375) * screen_width)
    static var topicsCollHeight = CGFloat((220/812) * screen_height) < 220 ?  220 : CGFloat((220/812) * screen_height)
    static var topicsCellHeight = TalksTablePropertyHeight.topicsCollHeight//CGFloat((180/812) * Screen.HEIGHT)
    static var tableHeaderCollectionHeight = CGFloat((450/812) * screen_height)
    static var tableHeaderCollectionCellWidth = CGFloat((339/375) * screen_width) - 27
    static var discussedCellHeight = CGFloat((431/812) * screen_height)
    static var mostDiscussedHomeCellHeight = CGFloat((385/812) * screen_height) < 350 ? 350 : CGFloat((385/812) * screen_height)
    static var discussedCellWidth = CGFloat((196/375) * screen_width)
}
