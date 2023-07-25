//
//  CategoryVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 03/07/2023.
//

import UIKit

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
            dataTableView.tableHeaderView?.height = 85.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        hitApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "Business Categories"
//        self.navigationController?.isNavigationBarHidden = true
    }
    
    public func hitApi(_ search: String = ""){
        containerView.backgroundColor = UIColor(named: "whitelightBlack")
        self.headerView.backgroundColor = UIColor.clear
        self.viewModel.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.viewModel.getCategoriesListing()
        })
    }
}

 extension CategoryVC {
    func commonInit() {
        loadingView = LoadingView(frame: containerView.frame, inView: view)
        loadingView?.show()
        setUI()
        self.headerSetup()
    }

    func setUI() {
        dataTableView.dataSource = self
        dataTableView.delegate = self
        dataTableView.registerCell(with: CategoryTitleCell.self)
    }


     public func viewMorebtnAction(section: Int){
         if let cell = self.dataTableView.cellForRow(at: IndexPath(row: section, section: 0)) as? CategoryTitleCell{
             DispatchQueue.main.async {
                 UIView.transition(with: cell.containerStackView,
                                   duration: 0.3,
                                   options: .curveEaseInOut) {
                     cell.containerStackView.setNeedsLayout()
                     cell.internalTableView.reloadTableView()
//                     self.dataTableView.performBatchUpdates({
                         self.dataTableView.reloadTableView()
//                     })
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
            hideSection(section: indexPath.row)
            cell.arrowIcon.rotate(clockwise: hiddenSections.contains(where: {$0.0 == indexPath.row}))
            cell.isRowShow = !hiddenSections.contains(where: {$0.0 == indexPath.row})
            //ToDo:- hiding tableview...
            UIView.animate(withDuration: !hiddenSections.contains(where: {$0.0 == indexPath.row}) ? 0.3 : 0.0) {
                cell.internalTableView.isHidden = !hiddenSections.contains(where: {$0.0 == indexPath.row})
            }
            UIView.transition(with: cell.containerStackView,
                              duration: 0.3,
                              options: .curveEaseInOut) {
                cell.containerStackView.setNeedsLayout()
                self.dataTableView.performBatchUpdates(nil)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return hiddenSections.contains(where: {$0.0 == indexPath.row}) ? UITableView.automaticDimension : 64.0
    }
    
    private func hideSection(section: Int) {
        if hiddenSections.contains(where: {$0.0 == section}) {
            hiddenSections.removeAll(where: {$0.0 == section})
        } else {
            if let sectionn = hiddenSections.first?.0{
                hiddenSections.removeAll(where: {$0.0 == sectionn})
                if let cells = dataTableView.cellForRow(at: IndexPath(row: sectionn, section: 0)) as? CategoryTitleCell{
                    cells.isRowShow = !hiddenSections.contains(where: {$0.0 == sectionn})
                    cells.internalTableView.isHidden = !hiddenSections.contains(where: {$0.0 == sectionn})
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
//        let vc = SuperYouHomeVC.instantiate(fromAppStoryboard: .Main)
//        vc.titleMsg =  self.viewModel.categories[index.row].name?.en ?? ""
//        self.navigationController?.pushViewController(vc, animated: false)
        let vc = CategoryDetailVC.instantiate(fromAppStoryboard: .Main)
        vc.titleMsg =  self.viewModel.categories[selectedIndexPath.row].children?[index.row].name?.en ?? ""
        self.navigationController?.pushViewController(vc, animated: false)
    }

    func cellDeleted() {

    }
}
class CustomTableView: UITableView{
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



extension CategoryVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        DispatchQueue.main.async {
            self.loadingView?.hide()
            self.loadingView?.removeFromSuperview()
            self.viewModel.searchValue = ""
            self.headerSetup()
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
extension CategoryVC: WalifSearchTextFieldDelegate{
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
    
    private func headerSetup(showSearchCount: Bool = false){
        if showSearchCount && !searchValue.isEmpty{
            headerView.searchResultCountLbl.isHidden = false
            headerView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: 109.0))
            let resultCount = self.viewModel.categories.reduce(0) { $0 + ($1.children?.count ?? 0) }
            headerView.searchResultCountLbl.text = "\(resultCount) results found"
            dataTableView.tableHeaderView?.height = 109.0
        }else{
            headerView.searchTxtFld.delegate = self
            headerView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height:  85.0))
            dataTableView.tableHeaderView = headerView
            headerView.searchResultCountLbl.isHidden = true
            dataTableView.tableHeaderView?.height = 85.0
        }
        self.dataTableView.reloadData()
    }

}
