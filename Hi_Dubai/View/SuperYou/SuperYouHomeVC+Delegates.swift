//
//  SuperYouHomeVC+Delegates.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import Foundation
import UIKit


//MARK:- TableViewCells
extension SuperYouHomeVC {
    
    /// Get Title Cell
    internal func getTitleCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeTitleData) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperYouTitleTableViewCell.self, indexPath: indexPath)
        return cell
    }
    
    /// Get Card Cell
    internal func getCardCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouCardData) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
//        cell.shimmerStatus = self.shimmerStatus
//        cell.clipsToBounds = true
        cell.currentCell = .cardCell
        cell.cardData = dataSource
        cell.configureCell()
        return cell
    }
    
    /// Get Upcoming Cell
    internal func getUpcomingCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
//        cell.shimmerStatus = self.shimmerStatus
//        cell.clipsToBounds = true
        cell.currentCell = .upcomingCell
        cell.superYouData = dataSource
        cell.configureCell()
        return cell
    }
    
    /// Get Live Now Cell
    internal func getLiveNowCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
//        cell.shimmerStatus = self.shimmerStatus
//        cell.clipsToBounds = true
        cell.currentCell = .liveClassesCell
        cell.superYouData = dataSource
        cell.configureCell()
        return cell
    }
    
    /// Get Most Loved Cell
    internal func getMostLovedClassesCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
//        cell.shimmerStatus = self.shimmerStatus
//        cell.clipsToBounds = true
        cell.currentCell = .mostLovedClassesCell
        cell.superYouData = dataSource
        cell.configureCell()
        return cell
    }
    
    /// Get Favourite Cell
    internal func getFavouriteCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
//        cell.shimmerStatus = self.shimmerStatus
//        cell.clipsToBounds = true
        cell.currentCell = .favoritesCell
        cell.superYouData = dataSource
        cell.configureCell()
        return cell
    }
    
    /// Get NewSuperShes Cell
    internal func getNewSuperShesCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
//        cell.shimmerStatus = self.shimmerStatus
//        cell.clipsToBounds = true
        cell.currentCell = .newSuperSheCell
        cell.superYouData = dataSource
        cell.configureCell()
        return cell
    }
    
    /// Get Featured Cell
    internal func getFeaturedCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
//        cell.shimmerStatus = self.shimmerStatus
//        cell.clipsToBounds = true
        cell.currentCell = .featuredCell
        cell.superYouData = dataSource
        cell.configureCell()
        return cell
    }
    
    /// Get SuperPowers
    internal func getCategoriesCell(_ tableView: UITableView, indexPath: IndexPath,dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
        cell.currentCell = .categories
        cell.superYouData = dataSource
        cell.configureCell()
        return cell
    }
    
    /// Get Past Live Cell
    internal func getpastLiveClassesCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: SuperYouHomeModel) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
        cell.currentCell = .pastLive
        cell.superYouData = dataSource
        cell.configureCell()
        return cell
    }
}
