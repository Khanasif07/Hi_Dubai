//
//  CategoryDetailVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 24/07/2023.
//

import UIKit

class CategoryDetailVC: BaseVC ,UINavigationBarDelegate{
    var titleMsg: String = ""
    var vm = CategoryDetailVM()
    @IBOutlet weak var navBarheightConst: NSLayoutConstraint!
    @IBOutlet weak var dataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = titleMsg
        if #available(iOS 15.0, *) {
            dataTableView.sectionHeaderTopPadding = 0.0
            dataTableView.sectionFooterHeight = 0.0
        }
        hitApi()
    }
    
    func hitApi() {
        self.vm.delegate = self
        self.vm.categoryData?.dataMappingInModel(jsonArr: [])
    }
    
    internal override func initialSetup() {
        registercell()
        self.navigationController?.navigationBar.isHidden = false
        addRightButtonToNavigation(image:UIImage(named: "search"), tintColor: .white)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navBarheightConst.constant = (navigationController?.navigationBar.frame.size.height ?? 0.0) + (navigationController?.navigationBar.frame.origin.y ?? 0.0)
        view.layoutIfNeeded()
    }
    
    private func registercell(){
        self.dataTableView.delegate = self
        self.dataTableView.dataSource = self
        self.dataTableView.separatorColor = .clear
        self.dataTableView.separatorStyle = .none
        self.dataTableView.registerHeaderFooter(with: CategoriesDetailSectionView.self)
        self.dataTableView.registerCell(with: SuperViewCardTableViewCell.self)
    }
}


extension CategoryDetailVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  vm.categoryData?.tableCellAtIndexPath.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CategoriesDetailSectionView") as? CategoriesDetailSectionView
        switch vm.categoryData?.tableCellAtIndexPath[section][0]{
        case .videoCell:
            headerView?.titleLbl.text = "TOP 10 RESTAURANTS YOU MIGHT LIKE"
            return headerView
        case .upcomingCell:
            headerView?.titleLbl.text = "NEW RESTAURANTS IN THE CITY"
            return headerView
        case .favoritesCell:
            headerView?.titleLbl.text = "EXCLUSIVE DEALS FOR YOU"
            return headerView
        case .liveClassesCell:
            headerView?.titleLbl.text = "NEAR BY RESTAURANTS"
            return headerView
        case .mostLovedClassesCell:
            headerView?.titleLbl.text = "BLOGS"
            return headerView
        case .categories:
            headerView?.titleLbl.text = "OTHER CATEGORIES"
            return headerView
        case .none:
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch vm.categoryData?.tableCellAtIndexPath[indexPath.section][0]{
        case .videoCell:
            return getCardCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .videoCell)
        case .upcomingCell:
            return getCardCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .upcomingCell)
        case .favoritesCell:
            return getCardCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .favoritesCell)
        case .liveClassesCell:
            return getCardCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .liveClassesCell)
        case .mostLovedClassesCell:
            return getCardCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .mostLovedClassesCell)
        case .categories:
            return getCardCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .categories)
        case .none:
            return getCardCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .videoCell)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch vm.categoryData?.tableCellAtIndexPath[indexPath.section][0]{
        case .videoCell:
            return 200.0
        case .upcomingCell:
            return 240.0
        case .favoritesCell:
            return 240.0
        case .liveClassesCell:
            return 220.0
        case .mostLovedClassesCell:
            return 220.0
        case .categories:
            return 260.0
        case .none:
            return 0.0
        }
    }
    
    func getCardCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: CategoryDetailModel,_ cellType: TableViewCells) -> UITableViewCell{
        let cell = tableView.dequeueCell(with: SuperViewCardTableViewCell.self, indexPath: indexPath)
        cell.cardCollectionView.backgroundColor = .black.withAlphaComponent(0.75)
//        cell.currentCell = cellType
        if let _ = self.vm.categoryData{
            cell.categoryData = dataSource
        }
        return cell
    }
}


extension CategoryDetailVC: CategoryDetailVMDelegate{
    
}
