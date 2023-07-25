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
        self.dataTableView.registerCell(with: CategoryCardViewTableCell.self)
        self.dataTableView.registerCell(with: SuperYouCategoriesTableCell.self)
        self.dataTableView.registerCell(with: CategoryAdvTableCell.self)
        self.dataTableView.registerCell(with: CategoryViewAllCell.self)
    }
}


extension CategoryDetailVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  vm.categoryData?.tableCellAtIndexPath.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch vm.categoryData?.tableCellAtIndexPath[section][0]{
        case .section1:
            return 1
        case .section2:
            return 3
        case .section3:
            return 2
        case .section4:
            return 2
        case .section5:
            return 2
        case .section6:
            return 1
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CategoriesDetailSectionView") as? CategoriesDetailSectionView
        switch vm.categoryData?.tableCellAtIndexPath[section][0]{
        case .section1:
            headerView?.gradientView.isHidden = true
            headerView?.titleLbl.text = "TOP 10 RESTAURANTS YOU MIGHT LIKE"
            return headerView
        case .section2:
            headerView?.gradientView.isHidden = false
            headerView?.titleLbl.text = "NEW RESTAURANTS IN THE CITY"
            return headerView
        case .section3:
            headerView?.gradientView.isHidden = false
            headerView?.titleLbl.text = "EXCLUSIVE DEALS FOR YOU"
            return headerView
        case .section4:
            headerView?.gradientView.isHidden = false
            headerView?.titleLbl.text = "NEAR BY RESTAURANTS"
            return headerView
        case .section5:
            headerView?.gradientView.isHidden = false
            headerView?.titleLbl.text = "BLOGS"
            return headerView
        case .section6:
            headerView?.gradientView.isHidden = false
            headerView?.titleLbl.text = "OTHER CATEGORIES"
            return headerView
        case .none:
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch vm.categoryData?.tableCellAtIndexPath[indexPath.section][0]{
        case .section1:
            return getCardCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .section1)
        case .section2:
            switch indexPath.row{
            case 0:
                return getCardCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .section2)
            case 1:
                return getCategoriesSeeMoreCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .section2)
            default:
                return getCategoriesAdvertismentCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .section2)
            }
        case .section3:
            switch indexPath.row{
            case 0:
                return getCardCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .section3)
            default:
                return getCategoriesSeeMoreCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .section3)
            }
        case .section4:
            switch indexPath.row{
            case 0:
                return getCardCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .section4)
            default:
                return getCategoriesSeeMoreCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .section4)
            }
        case .section5:
            if indexPath.row == 0 {
                return  getCardCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .section5)
            }else{
                return getCategoriesAdvertismentCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .section5)
            }
        case .section6:
            return getCategoriesCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .section6)
        case .none:
            return getCategoriesCell(tableView, indexPath: indexPath, dataSource: self.vm.categoryData!, .section1)
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
        case .section1:
            return 220.0
        case .section2:
            switch indexPath.row{
            case 0:
                return 250.0
            case 1:
                return 59.0
            default:
                return 120.0
                
            }
        case .section3:
            switch indexPath.row{
            case 0:
                return 250.0
            default:
                return 59.0
            }
        case .section4:
            switch indexPath.row{
            case 0:
                return 250.0
            default:
                return 59.0
            }
        case .section5:
            if indexPath.row == 0 {
                return 325.0
            }else{
                return 120.0
            }
        case .section6:
            return 108.0
        case .none:
            return 0.0
        }
    }
    
    private func getCardCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: CategoryDetailModel,_ cellType: CellContents) -> UITableViewCell{
        let cell = tableView.dequeueCell(with: CategoryCardViewTableCell.self, indexPath: indexPath)
        cell.currentCell = cellType
        if let _ = self.vm.categoryData{
            cell.categoryData = dataSource
        }
        return cell
    }
    
    private func getCategoriesCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: CategoryDetailModel,_ cellType: CellContents) -> UITableViewCell{
        let cell = tableView.dequeueCell(with: SuperYouCategoriesTableCell.self, indexPath: indexPath)
        if let _ = self.vm.categoryData{
            cell.categoriesData = dataSource
        }
        return cell
    }
    
    private func getCategoriesAdvertismentCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: CategoryDetailModel,_ cellType: CellContents) -> UITableViewCell{
        let cell = tableView.dequeueCell(with: CategoryAdvTableCell.self, indexPath: indexPath)
        return cell
    }
    
    private func getCategoriesSeeMoreCell(_ tableView: UITableView, indexPath: IndexPath, dataSource: CategoryDetailModel,_ cellType: CellContents) -> UITableViewCell{
        let cell = tableView.dequeueCell(with: CategoryViewAllCell.self, indexPath: indexPath)
        cell.seeMoreBtnTapped = { seeMoreBtn in
            print("See More Button Tapped..")
        }
        return cell
    }
}
