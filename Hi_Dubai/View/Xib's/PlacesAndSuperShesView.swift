//
//  PlacesAndSuperShesView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import UIKit
import Foundation
protocol PlacesAndSuperShesViewDelegate: NSObject {
    func closeTextFieldAnimation()
}

protocol LocateOnTheMap: NSObject {
    func locateWithLatLong(lon: String, andLatitude lat: String, andAddress address: String)
}

//MARK:- Enums-
enum CurrentlyUsingFor {
    case places,supershes,searchMovie, categories
}

class PlacesAndSuperShesView: UIView {
    
    var searchValue: String = ""
    lazy var viewModel = {
        NewsListViewModel()
    }()
    
    //MARK:- Variables
    //MARK:===========
    let maxCountForViewMore: Int = 11
    var lastContentOffset: CGFloat = 0.0
    var hiddenSections = Array<(Int,Bool)>()
    var headerView = CategoryHeaderView.instanciateFromNib()
    
    internal var screenUsingFor: CurrentlyUsingFor = .categories{
        willSet(newValue){
            self.screenUsingFor = newValue
        }
        didSet{
            configUI()
            self.viewModel.searchValue = ""
        }
    }
    internal weak var deleagte: PlacesAndSuperShesViewDelegate?
    
    internal var isScrollEnabled: Bool = false{
        didSet{
            self.dataTableView.isScrollEnabled = isScrollEnabled
        }
    }
    private var lat: String?
    private var long: String?
    internal weak var locationDelegate: LocateOnTheMap?
    internal var currentShimmerStatus: ShimmerState = .applied
    
    //MARK:- IBOutlets
    //MARK:===========
    @IBOutlet weak var dataTableView: UITableView! {
        didSet {
            self.dataTableView.backgroundColor = .clear
            self.dataTableView.sectionHeaderHeight          = 0.0//CGFloat.zero
            self.dataTableView.sectionFooterHeight          = 0.0//CGFloat.zero
            self.dataTableView.estimatedSectionHeaderHeight = 0.0//CGFloat.zero
            self.dataTableView.estimatedSectionFooterHeight = 0.0//CGFloat.zero
            //
            self.dataTableView.isScrollEnabled = isScrollEnabled
        }
    }
    
    private func footerSetup(){
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: Int(screen_width), height: Int(90.0))
        footerView.backgroundColor = .clear
        dataTableView.tableFooterView = footerView
    }
    
    private func headerSetup(showSearchCount: Bool = false){
        if showSearchCount{
            headerView.searchResultCountLbl.isHidden = false
            let resultCount = self.viewModel.categories.reduce(0) { $0 + ($1.children?.count ?? 0) }
            headerView.searchResultCountLbl.text = "\(resultCount) results found"
            dataTableView.tableHeaderView?.height = 109.0
        }else{
            headerView.searchResultCountLbl.isHidden = true
            headerView.searchTxtFld.delegate = self
            dataTableView.tableHeaderView = headerView
            dataTableView.tableHeaderView?.height = 85.0
        }
    }
    //MARK:- LifeCycle
    //MARK:===========
    //MARK:- LifeCycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpView()
    }
    
    //MARK:- Functions
    //MARK:===========
    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PlacesAndSuperShesView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
//        self.configUI()
    }
    
    private func configUI() {
        self.dataTableView.registerCell(with: ViewMoreTableViewCell.self)
        self.dataTableView.registerCell(with: TitleTableViewLastCell.self)
        self.dataTableView.registerCell(with: LoaderCell.self)
        self.dataTableView.registerCell(with: TitleTableViewCell.self)
        self.dataTableView.registerCell(with: PlacesAndSuperShesViewTableViewCell.self)
        self.dataTableView.registerHeaderFooter(with: CategoriesSectionView.self)
        self.dataTableView.delegate = self
        self.dataTableView.dataSource = self
        self.viewModel.delegate = self
        if screenUsingFor != .categories {
            self.footerSetup()
//            self.viewModel.searchValue = ""
        }else{
            self.viewModel.getCategoriesListing()
            self.headerSetup()
            if #available(iOS 15.0, *) {
                self.dataTableView.sectionHeaderTopPadding = 10.0
            }
        }
    }
    
    public func hitApi(_ search: String = ""){
        switch screenUsingFor{
        case .places:
            self.viewModel.getPumpkinListing(page: 1)
        case .supershes:
            self.viewModel.getPumpkinListing(page: 1)
        case .searchMovie:
            self.viewModel.getMovieListing(page: 1, search: searchValue)
        case .categories:
            print("Categories")
            self.dataTableView.reloadData()
        }
    }
}

//MARK:- Extensions- UITableView Delegate and DataSource
extension PlacesAndSuperShesView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.screenUsingFor {
        case .supershes,.places:
            return 1
        case .searchMovie:
            return 1
        default:
            return self.viewModel.categories.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.screenUsingFor {
        case .supershes,.places:
            return self.viewModel.pumkinsData.count + (self.viewModel.showPaginationLoader ?  1 : 0)
        case .searchMovie:
            return (self.viewModel.moviesResponse?.results.count ?? 0) + (self.viewModel.showPaginationLoader ?  1 : 0)
        default:
            if !self.hiddenSections.contains(where: { hiddenSection in
                hiddenSection.0 == section
            }) {
                return 0
            }
            let index  = self.hiddenSections.firstIndex(where: {$0.0 == section})!
            if ((self.viewModel.categories[section].children?.count ?? 0) > maxCountForViewMore) && !self.hiddenSections[index].1{
                return maxCountForViewMore
            }else{
                return self.viewModel.categories[section].children?.count ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.screenUsingFor {
        case .places,.supershes:
            if indexPath.row == (viewModel.pumkinsData.endIndex) {
                let cell = tableView.dequeueCell(with: LoaderCell.self)
                return cell
            }else {
                let cell = tableView.dequeueCell(with: PlacesAndSuperShesViewTableViewCell.self, indexPath: indexPath)
                cell.buttonTapped = { [weak self] (btn) in
                    guard let `self` = self else { return }
                    if self.viewModel.pumkinsData[indexPath.item].isSelected ==  true {
                        self.viewModel.pumkinsData[indexPath.item].isSelected = false
                        self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
                    }else{
                        self.viewModel.pumkinsData[indexPath.item].isSelected = true
                        self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
                cell.populatePumpkinCell(self.viewModel.pumkinsData[indexPath.item])
                return cell
            }
        case .searchMovie:
            if indexPath.row == (self.viewModel.moviesResponse?.results.endIndex ?? 0) {
                let cell = tableView.dequeueCell(with: LoaderCell.self)
                return cell
            }else{
                let cell = tableView.dequeueCell(with: PlacesAndSuperShesViewTableViewCell.self, indexPath: indexPath)
                cell.buttonTapped = { [weak self] (btn)  in
                    guard let `self` = self else { return }
                    if self.viewModel.moviesResponse?.results[indexPath.item].isSelected ==  true {
                        self.viewModel.moviesResponse?.results[indexPath.item].isSelected = false
                        self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
                    }else{
                        self.viewModel.moviesResponse?.results[indexPath.item].isSelected = true
                        self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
                cell.populateMovieCell(self.viewModel.moviesResponse?.results[indexPath.item])
                return cell
            }
        case .categories:
            if ((self.viewModel.categories[indexPath.section].children?.count ?? 0) < maxCountForViewMore+1){
                if (((self.viewModel.categories[indexPath.section].children?.count ?? 0) - 1) == indexPath.row){
                    let cell = tableView.dequeueCell(with: TitleTableViewLastCell.self, indexPath: indexPath)
                    cell.titleLbl.text = self.viewModel.categories[indexPath.section].children?[indexPath.row].name?.en ?? ""
                    return cell
                }else{
                    let cell = tableView.dequeueCell(with: TitleTableViewCell.self, indexPath: indexPath)
                    cell.titleLbl.text = self.viewModel.categories[indexPath.section].children?[indexPath.row].name?.en ?? ""
                    return cell
                }
            }else{
                let index = self.hiddenSections.firstIndex(where: {$0.0 == indexPath.section})
                if ((maxCountForViewMore-1) == indexPath.row) && !self.hiddenSections[index!].1{
                    let cell = tableView.dequeueCell(with: ViewMoreTableViewCell.self, indexPath: indexPath)
                    cell.buttonTapped = { [weak self] (btn) in
                        guard let `self` = self else { return }
                        self.hiddenSections[index!].1 = true
                        let newCount  = getCellCountForSection(sectionn: indexPath.section)
                        self.dataTableView.reloadRowsInSectionn(section: indexPath.section, oldCount: maxCountForViewMore, newCount: newCount)
                        self.dataTableView.performBatchUpdates {
                            let indexes = (0..<self.maxCountForViewMore).map { IndexPath(row: $0, section: indexPath.section) }
                            self.dataTableView.reloadRows(at: indexes, with: .none)
                        }
                    }
                    return cell
                }else if (((self.viewModel.categories[indexPath.section].children?.count ?? 0) - 1) == indexPath.row) && self.hiddenSections[index!].1{
                    let cell = tableView.dequeueCell(with: TitleTableViewLastCell.self, indexPath: indexPath)
                    cell.titleLbl.text = self.viewModel.categories[indexPath.section].children?[indexPath.row].name?.en ?? ""
                    return cell
                }else{
                    let cell = tableView.dequeueCell(with: TitleTableViewCell.self, indexPath: indexPath)
                    cell.titleLbl.text = self.viewModel.categories[indexPath.section].children?[indexPath.row].name?.en ?? ""
                    return cell
                }
            }
           
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch screenUsingFor{
        case .supershes,.places:
            if self.viewModel.pumkinsData[indexPath.item].isSelected ==  true {
                self.viewModel.pumkinsData[indexPath.item].isSelected = false
                self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
            }else{
                self.viewModel.pumkinsData[indexPath.item].isSelected = true
                self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        case .searchMovie:
            if let id = self.viewModel.moviesResponse?.results[indexPath.item].id{
                self.viewModel.getMovieDetail(path: String(id))
            }
        case .categories:
            print("Categories")
        }
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if screenUsingFor != .categories{
            return 85
        }else{
            if hiddenSections.contains(where: {$0.0 == indexPath.section}){
                return UITableView.automaticDimension
            }else{
                return 0.0
            }
        }
//        return screenUsingFor != .categories ? 85 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if screenUsingFor != .categories{
            return 85
        }else{
            if hiddenSections.contains(where: {$0.0 == indexPath.section}){
                return UITableView.automaticDimension
            }else{
                return 0.0
            }
        }
//        return screenUsingFor != .categories ? 85 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if screenUsingFor == .categories {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CategoriesSectionView") as? CategoriesSectionView {
                headerView.isRowShow    = !self.hiddenSections.contains(where: {$0.0 == section})
                headerView.titleLbl.text = self.viewModel.categories[section].name?.en ?? ""
                //MARK: - ButtonTapped Action...
                headerView.buttonTapped = { [weak self] (btn) in
                    guard let `self` = self else { return }
                    self.hideSection(sender: btn,section: section)
                    //Responsible for making header plane from rounded when rows are visible
                    headerView.isRowShow = !self.hiddenSections.contains(where: {$0.0 == section})
                    //Responsible for roation of arrow icons in section
                    headerView.arrowIcon.rotate(clockwise: self.hiddenSections.contains(where: {$0.0 == section}))
                }
                return headerView
            }
            return UIView()
        }else{
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return (screenUsingFor == .categories) ? 54.0 : CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  (screenUsingFor == .categories)  ? 54.0 : 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch screenUsingFor{
        case .supershes,.places:
            if cell as? LoaderCell != nil {
                if screenUsingFor == .supershes {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        self.viewModel.getPumpkinListing(page: self.viewModel.currentPage,loader: false,pagination: true)
                    })
                    
                }else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        self.viewModel.getPumpkinListing(page: self.viewModel.currentPage,loader: false,pagination: true)
                    })
                }
            }
        case .searchMovie:
            if cell as? LoaderCell != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                    self.viewModel.getMovieListing(page: self.viewModel.currentPage,loader: false,pagination: true,search: self.searchValue)
                })
            }
        case .categories:
            print("Categories")
        }
    }
    
    private func hideSection(sender: UIButton,section: Int) {
        //New Logic to update only rows
        let newCount  = getCellCountForSection(sectionn: section)
        if self.hiddenSections.contains(where: {$0.0 == section}) {
            self.hiddenSections.removeAll(where: {$0.0 == section})
            //New Logic to update only rows
            self.dataTableView.reloadRowsInSection(section: section, oldCount: newCount, newCount: 0)
            //Old Logic
            //            self.dataTableView.beginUpdates()
            //            self.dataTableView.reloadSections([section], with: .automatic)
            //            self.dataTableView.endUpdates()
        } else {
            if let sectionn = self.hiddenSections.first?.0{
                if sectionn < self.viewModel.categories.count{
                    //                    self.hiddenSections.removeAll(where: {$0.0 == sectionn})
                    //New Logic to update only rows
                    let newCountt  = getCellCountForSection(sectionn: sectionn)
                    self.hiddenSections.removeAll(where: {$0.0 == sectionn})
                    //New Logic to hide  line view for previous open visible section..
                    if let headerView = self.dataTableView.headerView(forSection: sectionn) as? CategoriesSectionView {
                        headerView.isRowShow = !self.hiddenSections.contains(where: {$0.0 == sectionn})
                    }
                    self.dataTableView.reloadRowsInSection(section: sectionn, oldCount: newCountt, newCount: 0)
                    //Old Logic
                    //                    self.dataTableView.beginUpdates()
                    //                    self.dataTableView.reloadSections([sectionn], with: .automatic)
                    //                    self.dataTableView.endUpdates()
                }
            }
            self.hiddenSections.append((section,false))
            //New Logic to update only rows
            self.dataTableView.reloadRowsInSection(section: section, oldCount: 0, newCount: newCount)
            //Old Logic
            //            self.dataTableView.beginUpdates()
            //            self.dataTableView.reloadSections([section], with: .automatic)
            //            self.dataTableView.endUpdates()
        }
        self.dataTableView.performBatchUpdates(nil)
    }
    
    private func getCellCountForSection(sectionn: Int)->Int{
        var newCountt: Int = 0
        if let indexx  = self.hiddenSections.firstIndex(where: {$0.0 == sectionn}){
            if (self.viewModel.categories[sectionn].children?.count ?? 0 > maxCountForViewMore) && !self.hiddenSections[indexx].1{
                newCountt =  maxCountForViewMore
            }else{
                newCountt =  self.viewModel.categories[sectionn].children?.count ?? 0
            }
        }else{
            if (self.viewModel.categories[sectionn].children?.count ?? 0 > maxCountForViewMore){
                newCountt =  maxCountForViewMore
            }else{
                newCountt =  self.viewModel.categories[sectionn].children?.count ?? 0
            }
        }
        return newCountt
    }
}
    


//MARK:- enableGlobalScrolling
extension PlacesAndSuperShesView{
    func enableGlobalScrolling(_ offset: CGFloat,_ isSearchHidden: Bool = true) {
        //        (self.parentViewController?.parent as? NavigationTypeVC)?.enableScrolling(offset,isSearchHidden)
    }
    
    func scrollViewDidScroll(_ scroll: UIScrollView) {
        if screenUsingFor == .categories{
           
        }else {
            var scrollDirection: ScrollDirection
            let stopScroll = 50.0
            if lastContentOffset > scroll.contentOffset.y {
                scrollDirection = .down
            } else {
                scrollDirection = .up
            }
            
            let offsetY = scroll.contentOffset.y
            
            lastContentOffset = scroll.contentOffset.y
            
            if scrollDirection == .up {
                if offsetY < stopScroll {
                    enableGlobalScrolling(offsetY)
                } else {
                    enableGlobalScrolling(stopScroll,false)
                }
            } else if (scrollDirection == .down) && (offsetY < stopScroll) {
                enableGlobalScrolling(offsetY)
            }
        }
    }
}


//MARK:- Extension NewsListViewModelDelegate
extension PlacesAndSuperShesView: NewsListViewModelDelegate{
    func pumpkinDataSuccess() {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
    
    func pumpkinDataFailure(error: Error) {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
    
    func movieDataSuccess() {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
            if (self.viewModel.moviesResponse?.results.count ?? 0) == 0 {
                (self.parentViewController?.parent as? NavigationTypeVC)?.showEmptyView()
            }else{
                (self.parentViewController?.parent as? NavigationTypeVC)?.hideEmptyView()
            }
        }
    }
    
    func movieDataFailure(error: Error) {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
            if (self.viewModel.moviesResponse?.results.count ?? 0) == 0 {
                (self.parentViewController?.parent as? NavigationTypeVC)?.showEmptyView()
            }else{
                (self.parentViewController?.parent as? NavigationTypeVC)?.hideEmptyView()
            }
        }
    }
    
    func movieDetailSuccess() {
        let secondVC = NewsDetailVC.instantiate(fromAppStoryboard: .Main)
        secondVC.isBackBtnShow = true
        DispatchQueue.main.async {
            secondVC.modalPresentationStyle = .overCurrentContext
            secondVC.viewModel.movie = self.viewModel.moviesDetail
            (self.parentViewController?.parent as? NavigationTypeVC)?.present(secondVC, animated: true)
            (self.parentViewController?.parent as? SuperYouHomeVC)?.present(secondVC, animated: true)
        }
    }
    
    func movieDetailFailure(error: Error) {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
    
    func newsListingSuccess() {
        DispatchQueue.main.async {
            self.viewModel.searchValue = ""
            self.dataTableView.reloadData()
        }
    }
}



// MARK: - WalifSearchTextFieldDelegate
extension PlacesAndSuperShesView: WalifSearchTextFieldDelegate{
    func walifSearchTextFieldBeginEditing(sender: UITextField!) {
        closeSearchingArea(false)
    }

    func walifSearchTextFieldEndEditing(sender: UITextField!) {
        closeSearchingArea(true)
        self.viewModel.searchValue = searchValue
        self.headerSetup(showSearchCount: !self.viewModel.searchValue.isEmpty)
        self.dataTableView.reloadData()
    }

    func walifSearchTextFieldChanged(sender: UITextField!) {
        self.searchValue = sender.text ?? ""
        self.viewModel.searchValue = searchValue
        self.headerSetup(showSearchCount: true)
        self.dataTableView.reloadData()

    }

    func walifSearchTextFieldIconPressed(sender: UITextField!) {
        closeSearchingArea(true)
        self.viewModel.searchValue = ""
        self.headerSetup()
        self.dataTableView.reloadData()
    }
    
    func closeSearchingArea(_ isTrue: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0.1,options: .curveEaseInOut) {
            self.headerView.searchTxtFld.crossBtnWidthConstant.constant = isTrue ? 0.0 : 50.0
            self.layoutIfNeeded()
        } completion: { value in
            self.headerView.searchTxtFld.cancelBtn.isHidden = isTrue
            self.layoutIfNeeded()
        }
    }

}

//MARK:- UITableView Extension to reload the tableview rows without reloading header...
extension UITableView{

    func reloadRowsInSection(section: Int, oldCount:Int, newCount: Int){
        
        let maxCount = max(oldCount, newCount)
        let minCount = min(oldCount, newCount)
        
        var changed = [IndexPath]()
        
        for i in minCount..<maxCount {
            let indexPath = IndexPath(row: i, section: section)
            changed.append(indexPath)
        }
        
        var reload = [IndexPath]()
        for i in 0..<minCount{
            let indexPath = IndexPath(row: i, section: section)
            reload.append(indexPath)
        }
        
        beginUpdates()
        if(newCount > oldCount){
            insertRows(at: changed, with: .automatic)
        }else if(oldCount > newCount){
            deleteRows(at: changed, with: .fade)
        }
        if(newCount > oldCount || newCount == oldCount){
            insertRows(at: reload, with: .automatic)
        }
        endUpdates()
    }

    func reloadRowsInSectionn(section: Int, oldCount:Int, newCount: Int){
        
        let maxCount = max(oldCount, newCount)
        let minCount = min(oldCount, newCount)
        
        var changed = [IndexPath]()
        
        for i in minCount..<maxCount {
            let indexPath = IndexPath(row: i, section: section)
            changed.append(indexPath)
        }
        
        var reload = [IndexPath]()
        for i in 0..<minCount{
            let indexPath = IndexPath(row: i, section: section)
            reload.append(indexPath)
        }
        
        beginUpdates()
        if(newCount > oldCount){
            insertRows(at: changed, with: .fade)
        }else if(oldCount > newCount){
            deleteRows(at: changed, with: .fade)
        }
        endUpdates()
    }
    
//    func scrollToEnd(_ inSection: Int) {
//        if numberOfRows(inSection: inSection) > 0 {
////            let index = NSIndexPath(row: 0, section: inSection) as IndexPath
////            self.scrollToRow(at: index, at: .none, animated: false)
//            self.scrollToNearestSelectedRow(at: .none, animated: false)
//        }
//    }
}
