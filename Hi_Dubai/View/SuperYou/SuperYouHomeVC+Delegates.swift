//
//  SuperYouHomeVC+Delegates.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import Foundation
import UIKit
import SwiftUI

//MARK:- TableViewCells
extension SuperYouHomeVC {
    
    /// Get Title Cell
    internal func getTitleCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperYouTitleTableViewCell.self, indexPath: indexPath)
        if cell.containerView.subviews.isEmpty{
            initCarbonSwipeUI(targetView: cell.containerView)
        }
        return cell
    }
    
    /// Get Card Cell
    internal func getMusicCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
//        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
//        cell.currentCell = .music
//        cell.superYouData = dataSource
//        cell.configureCell()
//        return cell
        let cell = tableView.dequeueCell(with: SuperYouMusicTableCell.self, indexPath: indexPath)
        cell.superYouData = dataSource
        return cell
    }
    
    /// Get Upcoming Cell
    internal func getUpcomingCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
        cell.currentCell = .upcomingCell
        cell.superYouData = dataSource
//        cell.configureCell()
        return cell
    }
    
    /// Get Live Now Cell
    internal func getLiveNowCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
        cell.currentCell = .liveClassesCell
        cell.superYouData = dataSource
//        cell.configureCell()
        return cell
    }
    
    /// Get Most Loved Cell
    internal func getMostLovedClassesCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
        cell.currentCell = .mostLovedClassesCell
        //
        if #available(iOS 16.0, *) {
            
            cell.superYouData = dataSource
//            cell.configureCell()
        } else {
            // Fallback on earlier versions
            cell.superYouData = dataSource
//            cell.configureCell()
        }
        return cell
    }
    
    /// Get Favourite Cell
    internal func getFavouriteCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
        cell.currentCell = .favoritesCell
        cell.superYouData = dataSource
//        cell.configureCell()
        return cell
    }
    
    /// Get NewSuperShes Cell
    internal func getNewSuperShesCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
        cell.currentCell = .newSuperSheCell
        //
        if #available(iOS 16.0, *) {
//            cell.configureCell()
            cell.superYouData = dataSource
        } else {
            // Fallback on earlier versions
            cell.superYouData = dataSource
//            cell.configureCell()
        }
        //
        return cell
    }
    
    /// Get Featured Cell
    internal func getFeaturedCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
        cell.currentCell = .featuredCell
        
//
        if #available(iOS 16.0, *) {
//            cell.configureCell()
            cell.superYouData = dataSource
        } else {
            // Fallback on earlier versions
            cell.superYouData = dataSource
//            cell.configureCell()
        }
//
        cell.emptyView.isHidden = !dataSource.featuredDataArr.isEmpty
        cell.pageControl.isHidden = dataSource.featuredDataArr.isEmpty
        return cell
    }
    
    /// Get Categories
    internal func getCategoriesCell(_ tableView: UITableView, indexPath: IndexPath,dataSource: SuperYouHomeModel) -> UITableViewCell {
//        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
//        cell.currentCell = .categories
//        cell.superYouData = dataSource
//        cell.configureCell()
        let cell = tableView.dequeueCell(with: SuperYouCategoriesTableCell.self, indexPath: indexPath)
        cell.superYouData = dataSource
        return cell
    }
    
    /// Get BusinessCategorie
    internal func getBusinessCategoriesCell(_ tableView: UITableView, indexPath: IndexPath,dataSource: SuperYouHomeModel) -> UITableViewCell {
//        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
       
//        cell.superYouData = dataSource
//        cell.configureCell()
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
        cell.currentCell = .businessCategories
        cell.superYouData = dataSource
        return cell
    }
    
    /// Get Past Live Cell
    internal func getpastLiveClassesCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperYouPastLivTableCell.self, indexPath: indexPath)
//        cell.currentCell = .pastLive
        cell.superYouData = dataSource
//        cell.configureCell()
        return cell
    }
}
