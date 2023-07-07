//
//  BusinessCategoriesVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 06/07/2023.
//

import UIKit

class BusinessCategoriesVC: UIViewController {
    
    var heightCache: [IndexPath: CGFloat] = [:]
    private var frozenContentOffsetForRowAnimation: CGPoint?

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dataTableView: UITableView! {
        didSet {
            self.dataTableView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
            self.dataTableView.sectionHeaderHeight          = 0.0//CGFloat.zero
            self.dataTableView.sectionFooterHeight          = 0.0//CGFloat.zero
            self.dataTableView.estimatedSectionHeaderHeight = 0.0//CGFloat.zero
            self.dataTableView.estimatedSectionFooterHeight = 0.0//CGFloat.zero
            //
            self.dataTableView.isScrollEnabled = isScrollEnabled
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView = LoadingView(frame: containerView.frame, inView: view)
        loadingView?.show()
        self.configUI()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    var loadingView: LoadingView?
    var searchValue: String = ""
    lazy var viewModel = {
        NewsListViewModel()
    }()
    
    //MARK:- Variables
    //MARK:===========
    let maxCountForViewMore: Int = 11
    var hiddenSections = Array<(Int,Bool)>()
    var headerView = CategoryHeaderView.instanciateFromNib()
    
    internal weak var deleagte: PlacesAndSuperShesViewDelegate?
    
    internal var isScrollEnabled: Bool = true{
        didSet{
            self.dataTableView.isScrollEnabled = isScrollEnabled
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK:- IBOutlets
    //MARK:===========
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    //MARK:- Functions
    //MARK:===========
    
    private func setUpView() {
        containerView.backgroundColor = .white
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        hitApi()
    }
    
    private func configUI() {
        self.dataTableView.registerCell(with: ViewMoreTableViewCell.self)
        self.dataTableView.registerCell(with: TitleTableViewLastCell.self)
        self.dataTableView.registerCell(with: TitleTableViewCell.self)
        self.dataTableView.registerHeaderFooter(with: CategoriesSectionView.self)
        self.dataTableView.delegate = self
        self.dataTableView.dataSource = self
        self.viewModel.delegate = self
        self.headerSetup()
        if #available(iOS 15.0, *) {
            self.dataTableView.sectionHeaderTopPadding = 10.0
        }
    }
    
    public func hitApi(_ search: String = ""){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.viewModel.getCategoriesListing()
        })
    }
}


extension BusinessCategoriesVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
            return self.viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Categories")
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        if hiddenSections.contains(where: {$0.0 == indexPath.section}){
//            return UITableView.automaticDimension
//        }else{
//            return 0.0
//        }
        return heightCache[indexPath] ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            if hiddenSections.contains(where: {$0.0 == indexPath.section}){
//                return UITableView.automaticDimension
//            }else{
//                return 0.0
//            }
        return heightCache[indexPath] ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return  54.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  54.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            print("Categories")
        heightCache[indexPath] = cell.bounds.size.height
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
    
//MARK:- Extension NewsListViewModelDelegate
extension BusinessCategoriesVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        DispatchQueue.main.async {
            self.loadingView?.hide()
            self.loadingView?.removeFromSuperview()
            self.viewModel.searchValue = ""
            self.dataTableView.reloadData()
        }
    }
    
    func newsListingFailure(error: Error) {
        DispatchQueue.main.async {
            self.loadingView?.hide()
            self.loadingView?.removeFromSuperview()
            self.viewModel.searchValue = ""
            self.dataTableView.reloadData()
        }
    }
}

// MARK: - WalifSearchTextFieldDelegate
extension BusinessCategoriesVC: WalifSearchTextFieldDelegate{
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
            self.view.layoutIfNeeded()
        } completion: { value in
            self.headerView.searchTxtFld.cancelBtn.isHidden = isTrue
            self.view.layoutIfNeeded()
        }
    }

}


extension BusinessCategoriesVC{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        frozenContentOffsetForRowAnimation = nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if let overrideOffset = frozenContentOffsetForRowAnimation, scrollView.contentOffset != overrideOffset {
//            scrollView.setContentOffset(overrideOffset, animated: false)
//        }
        print("ScrollView_OffSet.y:-\(scrollView.contentOffset.y)")
        print("===")
        print("ScrollView_Content_size:-\(scrollView.contentSize)")
        print("===")
        print("ScrollView_frame:-\(scrollView.frame)")
    }
}
