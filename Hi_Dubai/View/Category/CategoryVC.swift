//
//  CategoryVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 03/07/2023.
//

import UIKit
import FontAwesome_swift
protocol HeplerDelegate: NSObject {
    func heightChanged()
    func cellAdded()
    func cellSelected(_ selectedIndexPath:IndexPath, index: IndexPath)
    func cellDeleted()
}
var hiddenSections = Array<(Int,Bool)>()
class CategoryVC: UIViewController {

    var loadingView: LoadingView?
    var searchValue: String = ""
    lazy var viewModel = {
        NewsListViewModel()
    }()
    var headerView = CategoryHeaderView.instanciateFromNib()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dataTableView: CustomTableView!{
        didSet {
            self.dataTableView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
            self.dataTableView.sectionHeaderHeight          = 0.0//CGFloat.zero
            self.dataTableView.sectionFooterHeight          = 0.0//CGFloat.zero
            self.dataTableView.estimatedSectionHeaderHeight = 0.0//CGFloat.zero
            self.dataTableView.estimatedSectionFooterHeight = 0.0//CGFloat.zero
            dataTableView.tableHeaderView?.height = 87.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        hitApi()
        
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "Business Categories"
//        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        hiddenSections = []
        //
    }
    
    public func hitApi(_ search: String = ""){
        containerView.backgroundColor = UIColor(named: "whitelightBlack")
        self.headerView.backgroundColor = UIColor.clear
        self.viewModel.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.viewModel.getCategoriesListing()
        })
    }
    
    private func reloadTableView(){
        UIView.animate(withDuration: 0.5) {
            self.dataTableView.reloadData()
        }
    }
}

 extension CategoryVC {
     private func commonInit() {
        loadingView = LoadingView(frame: containerView.frame, inView: view)
        loadingView?.show()
        setUI()
        self.headerSetup()
    }

     private func setUI() {
        dataTableView.dataSource = self
        dataTableView.delegate = self
        dataTableView.registerCell(with: CategoryTitleCell.self)
    }
     
     private func initSetUp(_ indexPath:IndexPath =  IndexPath(row: 0, section: 0)){
         if let cell = self.dataTableView.cellForRow(at: indexPath) as? CategoryTitleCell{
             DispatchQueue.main.async {
                 self.hideSection(section: indexPath.row)
                 cell.arrowIcon.rotate(clockwise: hiddenSections.contains(where: {$0.0 == indexPath.row}))
                 cell.isRowShow = !hiddenSections.contains(where: {$0.0 == indexPath.row})
                 //ToDo:- hiding tableview...
                 UIView.animate(withDuration: !hiddenSections.contains(where: {$0.0 == indexPath.row}) ? 0.01 : 0.01) {
                     cell.internalTableView.isHidden = !hiddenSections.contains(where: {$0.0 == indexPath.row})
                 }
                 UIView.transition(with: cell.containerStackView,
                                   duration: 0.4,
                                   options: .curveEaseInOut) {
                     cell.containerStackView.setNeedsLayout()
                     self.dataTableView.performBatchUpdates(nil)
                 }
             }
         }
     }


     public func viewMoreLessbtnAction(section: Int){
         if let cell = self.dataTableView.cellForRow(at: IndexPath(row: section, section: 0)) as? CategoryTitleCell{
             DispatchQueue.main.async {
                 UIView.transition(with: cell.containerStackView,
                                   duration: 0.4,
                                   options: .curveEaseInOut) {
                     cell.containerStackView.setNeedsLayout()
                     cell.internalTableView.reloadData()
                     self.reloadTableView()
                 }
             }
         }
     }
     
}
//MARK: Tableview delegates
extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: CategoryTitleCell.self)
        cell.helperDelegate = self
        //
        cell.isRowShow    = !hiddenSections.contains(where: {$0.0 == indexPath.row})
        cell.selectedIndexPath = indexPath
        cell.configuree(withModel: self.viewModel.categories[indexPath.row])
        cell.internalTableView.isHidden = !hiddenSections.contains(where: {$0.0 == indexPath.row})
        cell.buttonTapped = { [weak self] (btn) in
            guard let `self` = self else { return }
            //
//            if hiddenSections.contains(where: {$0.0 == indexPath.row}) { return }
            //
            DispatchQueue.main.async {
                self.hideSection(section: indexPath.row)
                cell.arrowIcon.rotate(clockwise: hiddenSections.contains(where: {$0.0 == indexPath.row}))
                cell.isRowShow = !hiddenSections.contains(where: {$0.0 == indexPath.row})
                //ToDo:- hiding tableview...
//                UIView.animate(withDuration: !hiddenSections.contains(where: {$0.0 == indexPath.row}) ? 0.4 : 0.01) {
//                    cell.internalTableView.isHidden = !hiddenSections.contains(where: {$0.0 == indexPath.row})
//                }
                UIView.transition(with: cell.containerStackView,
                                  duration: 0.4,
                                  options: .curveEaseInOut) {
                    cell.internalTableView.isHidden = !hiddenSections.contains(where: {$0.0 == indexPath.row})
                    cell.containerStackView.setNeedsLayout()
                    self.dataTableView.performBatchUpdates(nil)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return hiddenSections.contains(where: {$0.0 == indexPath.row}) ? UITableView.automaticDimension : 64.0
        if hiddenSections.contains(where: {$0.0 == indexPath.row}) {
            if let index  = hiddenSections.firstIndex(where: {$0.0 == indexPath.row}){
                if ((self.viewModel.categories[indexPath.row].children?.count ?? 0) > maxCountForViewMore) && !hiddenSections[index].1{
                    return CGFloat(maxCountForViewMore) * 36.0 + 82.0
                }else{
                    if ((self.viewModel.categories[indexPath.row].children?.count ?? 0) > maxCountForViewMore){
                        return CGFloat(self.viewModel.categories[indexPath.row].children?.count ?? 0 + 1) * 36.0 + 82.0
                    }
                    return CGFloat((self.viewModel.categories[indexPath.row].children?.count ?? 0)) * 36.0 + 82.0
                }
            }else{
                if ((self.viewModel.categories[indexPath.row].children?.count ?? 0) > maxCountForViewMore){
                    return CGFloat(maxCountForViewMore) * 36.0 + 82.0
                }else{
                    if ((self.viewModel.categories[indexPath.row].children?.count ?? 0) > maxCountForViewMore){
                        return CGFloat(self.viewModel.categories[indexPath.row].children?.count ?? 0 + 1) * 36.0 + 82.0
                    }
                    return CGFloat((self.viewModel.categories[indexPath.row].children?.count ?? 0)) * 36.0 + 82.0
                }
            }
        }else{
            return 64.0
        }
    }
    
    private func hideSection(section: Int) {
        if hiddenSections.contains(where: {$0.0 == section}) {
            hiddenSections.removeAll(where: {$0.0 == section})
        } else {
            if let sectionn = hiddenSections.first?.0{
                hiddenSections.removeAll(where: {$0.0 == sectionn})
                if let cells = dataTableView.cellForRow(at: IndexPath(row: sectionn, section: 0)) as? CategoryTitleCell{
                    //ToDo:- hiding tableview...
                    UIView.animate(withDuration: 0.4,delay: 0.01) {
                        cells.arrowIcon.rotate(clockwise: hiddenSections.contains(where: {$0.0 == section}))
                        cells.isRowShow = !hiddenSections.contains(where: {$0.0 == sectionn})
                    }
                }
            }
            hiddenSections.append((section,false))
        }
    }
}

extension CategoryVC: HeplerDelegate {
    func heightChanged() {
        dataTableView.performBatchUpdates(nil)
    }

    func cellAdded() {

    }
    
    func cellSelected(_ selectedIndexPath: IndexPath,index: IndexPath) {
        let vc = CategoryDetailVC.instantiate(fromAppStoryboard: .Main)
        vc.titleMsg =  self.viewModel.categories[selectedIndexPath.row].children?[index.row].name?.en ?? ""
        self.navigationController?.pushViewController(vc, animated: false)
    }

    func cellDeleted() {

    }
}
//MARK: - Custom Table View..
class CustomTableView: UITableView {
    public override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }

    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}

//MARK: - NewsListViewModelDelegate
extension CategoryVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        DispatchQueue.main.async {
            self.loadingView?.hide()
            self.loadingView?.removeFromSuperview()
            self.viewModel.searchValue = ""
            self.headerSetup()
            self.reloadTableView()
            //
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.initSetUp()
            })
            //
        }
       
    }
    
    func newsListingFailure(error: Error) {
        DispatchQueue.main.async {
            self.loadingView?.hide()
            self.loadingView?.removeFromSuperview()
            self.viewModel.searchValue = ""
            self.reloadTableView()
        }
    }
}


// MARK: - WalifSearchTextFieldDelegate
extension CategoryVC: WalifSearchTextFieldDelegate{
    func walifSearchTextFieldBeginEditing(sender: UITextField!) {
        closeSearchingArea(false)
    }

    func walifSearchTextFieldEndEditing(sender: UITextField!) {
        self.searchValue = sender.text ?? ""
        closeSearchingArea(self.searchValue.isEmpty)
        self.viewModel.searchValue = searchValue
        self.headerSetup(showSearchCount: !self.viewModel.searchValue.isEmpty)
        self.reloadTableView()
    }

    func walifSearchTextFieldChanged(sender: UITextField!) {
        self.searchValue = sender.text ?? ""
        self.viewModel.searchValue = searchValue
        //
        hiddenSections = []
        for (index,_) in self.viewModel.categories.enumerated(){
            hiddenSections.append((index,false))
        }
        //
        self.headerSetup(showSearchCount: true)
        self.reloadTableView()
        //Equatable Logic..
        print("Is Equal:-\(self.viewModel.businessCategories == self.viewModel.categories)")

    }

    func walifSearchTextFieldIconPressed(sender: UITextField!) {
        self.headerView.searchTxtFld.mainTF.text = ""
        self.searchValue = sender.text ?? ""
        self.viewModel.searchValue = searchValue
        closeSearchingArea(self.searchValue.isEmpty)
        //
        hiddenSections = []
        //
        self.headerSetup()
        self.reloadTableView()
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.initSetUp()
        })
        //
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
    
    private func headerSetup(showSearchCount: Bool = false){
        if showSearchCount && !searchValue.isEmpty{
            headerView.searchResultCountLbl.isHidden = false
            headerView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: 113.0))
            let resultCount = self.viewModel.categories.reduce(0) { $0 + ($1.children?.count ?? 0) }
            headerView.searchResultCountLbl.text = "\(resultCount) results found"
            dataTableView.tableHeaderView?.height = 113.0
        }else{
            headerView.searchTxtFld.delegate = self
            headerView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height:  87.0))
            dataTableView.tableHeaderView = headerView
            headerView.searchResultCountLbl.isHidden = true
            dataTableView.tableHeaderView?.height = 87.0
        }
    }

}
