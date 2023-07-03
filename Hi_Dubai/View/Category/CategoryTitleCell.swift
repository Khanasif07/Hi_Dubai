//
//  CategoryTitleCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 03/07/2023.
//

import UIKit
var maxCountForViewMore: Int = 6
var viewMoreSelected: Bool = false
class CategoryTitleCell: UITableViewCell {

    var helperDelegate: HeplerDelegate?
    var model: Goal?
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
        internalTableView.isHidden = true
        internalTableView.delegate = self
        internalTableView.dataSource = self
        internalTableView.registerCell(with: SubCategoryTableViewCell.self)
        internalTableView.registerCell(with: ViewMoreCell.self)
        internalTableView.estimatedRowHeight = 36
        internalTableView.rowHeight = UITableView.automaticDimension
        internalTableView.allowsSelection = false
        internalTableView.backgroundColor =  UIColor.black.withAlphaComponent(0.75)
        self.isRowShow = !self.internalTableView.isHidden
        // Initialization code
    }
    
    var isRowShow: Bool = false{
        didSet{
            lineView.backgroundColor = isRowShow ? .white : .black
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
    }
}

//MARK: Tableview delegates
extension CategoryTitleCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ((model?.Actions.count ?? 0) > maxCountForViewMore) && !viewMoreSelected{
            return maxCountForViewMore
        }else{
            return model?.Actions.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ((maxCountForViewMore-1) == indexPath.row) && !viewMoreSelected{
            let cell = tableView.dequeueCell(with: ViewMoreCell.self, indexPath: indexPath)
            cell.buttonTapped = { [weak self] (btn) in
                guard let `self` = self else { return }
                viewMoreSelected = true
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
            let action = model?.Actions[indexPath.row] ?? Action(title: "")
            cell.configure(withModel: action)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36.0
    }
}
