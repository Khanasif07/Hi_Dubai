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
           return UITableViewCell()
        case .applied:
        
            if let superYouData = self.viewModel.superYouData {
                
//                if self.viewModel.nextPageStatus && superYouData.tableCellAtIndexPath.count - 1 == indexPath.section && self.viewModel.apiHitCount == 1 {
//                    self.viewModel.getSuperMeData(isPullToRefresh: false)
//                }
                
                switch superYouData.tableCellAtIndexPath[indexPath.section][indexPath.row] {
               
                case .videoCell:
                    return self.getTitleCell(tableView, indexPath: indexPath, dataSource: superYouData)
                case .music:
                    return self.getMusicCell(tableView, indexPath: indexPath, dataSource: superYouData)
                    
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
                case .videoCell:
                    headerView.headerViewSetUpForSuperYou(title: "Video Cell", toShowSeeAll: superYouData.videoData.count > 2)
                    return headerView
                case .upcomingCell:
                    headerView.headerViewSetUpForSuperYou(title: "Upcoming Deals", toShowSeeAll: superYouData.upcomingDataArr.count > 2)
                    return headerView
                    
                case .liveClassesCell:
                    headerView.headerViewSetUpForSuperYou(title: "Super She Live Now", toShowSeeAll: superYouData.liveNowDataArr.count >= 2)
                    return headerView
                    
                case .favoritesCell:
                    headerView.headerViewSetUpForSuperYou(title: "New From MyFriends", toShowSeeAll: superYouData.favouriteDataArr.count > 3)
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
                case .music:
                    headerView.headerViewSetUpForSuperYou(title: "Music", toShowSeeAll: superYouData.categories.count > 2)
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
            case .videoCell:
                return 0.0
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
            case .music:
                return 50.0
            default: return CGFloat.leastNonzeroMagnitude
            }
        }
        return CGFloat.leastNonzeroMagnitude
    }
    
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
            return UITableView.automaticDimension
        case .applied:
            if let superYouData = self.viewModel.superYouData {
                switch superYouData.tableCellAtIndexPath[indexPath.section][indexPath.row] {
                case .videoCell:
                    return 640.0
                case .music:
                    let numberOfColumn: CGFloat = 3
                    let sizeForItemHeight : CGFloat = 55
                    let spacing: CGFloat = 10.0 // mininteritemspacing
                    let availableHeight = (sizeForItemHeight * numberOfColumn) + spacing * (numberOfColumn - 1)
                    // triple height + gap * 2
                    return  availableHeight
                case .upcomingCell:
                    // double height + gap * 1
                    let numberOfColumn: CGFloat = 2
                    let sizeForItemHeight : CGFloat = 215.0
                    let spacing: CGFloat = 10.0 // mininteritemspacing
                    let availableHeight = (sizeForItemHeight * numberOfColumn) + spacing * (numberOfColumn - 1)
                    // triple height + gap * 2
                    return  availableHeight
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
                case .categories:
                    return  self.viewModel.superYouData!.isFirstTime ? 90.0
                    : 45.0
                default:
                    return 220.0
                }
            }
            return 220.0
        case .none:
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}

extension SuperYouHomeVC: SuperYouHomeVMDelegate {
    func willHitSuperYouApi() {
    }
    func getSuperYouDataSuccess(successMsg: String, isPullToRefresh: Bool, lastPageScrolled: Int) {
        self.dataTableView.reloadData()
    }
    func endPullTorefreshRequest(lastPageScrolled: Int) {
    }
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
