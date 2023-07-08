//
//  CategoryTitleCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 03/07/2023.
//

import UIKit
var maxCountForViewMore: Int = 10
var viewMoreSelected: Bool = false
class CategoryTitleCell: UITableViewCell {

    var helperDelegate: HeplerDelegate?
    var model: Goal?
    var modele: Category?
    var buttonTapped: ((UIButton) -> Void)?
    var selectedIndexPath: IndexPath?
   

    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var internalTableView: CustomTableView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var arrowIcon: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        internalTableView.isHidden = true
        internalTableView.delegate = self
        internalTableView.dataSource = self
        internalTableView.registerCell(with: SubCategoryTableViewCell.self)
        internalTableView.registerCell(with: ViewMoreCell.self)
        internalTableView.estimatedRowHeight = 36
        internalTableView.rowHeight = UITableView.automaticDimension
        internalTableView.allowsSelection = false
//        internalTableView.backgroundColor =  UIColor.black.withAlphaComponent(0.75)
        self.isRowShow = !self.internalTableView.isHidden
        // Initialization code
    }
    
    var isRowShow: Bool = false{
        didSet{
            lineView.backgroundColor = !isRowShow ? .white : .black
            arrowIcon.setImage(!isRowShow ? UIImage(named: "icons8-arrow_up-35")! : UIImage(named: "icons8-arrow-35")! , for: .normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = 5.0
        outerView.layer.cornerRadius = 5.0
    }
    
    
    @IBAction func sectionTapped(_ sender: UIButton) {
        if let handle = buttonTapped{
            handle(sender)
        }
    }
}


//MARK: Configure
extension CategoryTitleCell {
    func configure(withModel model: Goal) {
        self.model = model
        self.titleLbl.text = model.title
        self.internalTableView.reloadData()
    }
    
    func configuree(withModel model: Category) {
        self.modele = model
        self.titleLbl.text = modele?.name?.en ?? ""
        self.internalTableView.reloadData()
    }
}

//MARK: Tableview delegates
extension CategoryTitleCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let index  = hiddenSections.firstIndex(where: {$0.0 == selectedIndexPath?.row ?? 0}){
            if ((modele?.children?.count ?? 0) > maxCountForViewMore) && !hiddenSections[index].1{
                return maxCountForViewMore
            }else{
                return modele?.children?.count ?? 0
            }
        }else{
            if ((modele?.children?.count ?? 0) > maxCountForViewMore){
                return maxCountForViewMore
            }else{
                return modele?.children?.count ?? 0
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let index = hiddenSections.firstIndex(where: {$0.0 == selectedIndexPath?.row ?? 0}){
            if ((maxCountForViewMore-1) == indexPath.row) && !hiddenSections[index].1{
                let cell = tableView.dequeueCell(with: ViewMoreCell.self, indexPath: indexPath)
                cell.buttonTapped = { [weak self] (btn) in
                    guard let `self` = self else { return }
                    hiddenSections[index].1 = true
                    (self.parentViewController as? CategoryVC)?.viewMorebtnAction(section: selectedIndexPath?.row ?? 0)
//                    UIView.transition(with: containerStackView,
//                                      duration: 0.3,
//                                      options: .curveEaseInOut) {
//                        self.containerStackView.setNeedsLayout()
//                        self.internalTableView.reloadTableView()
//                        (self.parentViewController as? CategoryVC)?.dataTableView.performBatchUpdates({
//                            (self.parentViewController as? CategoryVC)?.dataTableView.reloadRows(at: [IndexPath(row: self.selectedIndexPath?.row ?? 0, section: self.selectedIndexPath?.section ?? 0)], with: .automatic)
//                        })
//                    }
                }
                return cell
            }else{
                let cell = tableView.dequeueCell(with: SubCategoryTableViewCell.self)
                let action = modele?.children?[indexPath.row] ?? Child()
                cell.configuree(withModel: action)
                return cell
            }
        }else{
            if ((maxCountForViewMore-1) == indexPath.row){
                let cell = tableView.dequeueCell(with: ViewMoreCell.self, indexPath: indexPath)
                cell.buttonTapped = { [weak self] (btn) in
                    guard let `self` = self else { return }
                    if let index = hiddenSections.firstIndex(where: {$0.0 == self.selectedIndexPath?.row ?? 0}){
                        hiddenSections[index].1 = true
                    }else{
                        
                    }
                    UIView.transition(with: containerStackView,
                                      duration: 0.3,
                                      options: .curveEaseInOut) {
                        self.containerStackView.setNeedsLayout()
                        self.internalTableView.reloadTableView()
                        (self.parentViewController as? CategoryVC)?.dataTableView.performBatchUpdates({
                            (self.parentViewController as? CategoryVC)?.dataTableView.reloadRows(at: [IndexPath(row: self.selectedIndexPath?.row ?? 0, section: self.selectedIndexPath?.section ?? 0)], with: .automatic)
                        })
                    }
                }
                return cell
            }else{
                let cell = tableView.dequeueCell(with: SubCategoryTableViewCell.self)
                let action = modele?.children?[indexPath.row] ?? Child()
                cell.configuree(withModel: action)
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36.0
    }
}
