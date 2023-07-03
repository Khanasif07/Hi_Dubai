//
//  CategoryTitleCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 03/07/2023.
//

import UIKit

class CategoryTitleCell: UITableViewCell {

    var helperDelegate: HeplerDelegate?
    var model: Goal?
    var buttonTapped: ((UIButton) -> Void)?
    var hiddenSections = Set<Int>()

    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var internalTableView: UITableView!
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
        let selectedIndex = (parentViewController as? CategoryVC)?.dataTableView.indexPath(forItem: sender)?.row ?? 0
        hideSection(sender: sender, section: selectedIndex)
        self.internalTableView.isHidden = !hiddenSections.contains(selectedIndex)
        UIView.transition(with: containerStackView,
                          duration: 0.3,
                          options: .curveEaseInOut) {
            self.containerStackView.setNeedsLayout()
            self.helperDelegate?.heightChanged()
        }
        self.isRowShow = !self.internalTableView.isHidden
    }
    
    private func hideSection(sender: UIButton,section: Int) {
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
        } else {
            if let sectionn = self.hiddenSections.first{
                self.hiddenSections.remove(sectionn)
            }
            self.hiddenSections.insert(section)
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
        return model?.Actions.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SubCategoryTableViewCell.self)
        let action = model?.Actions[indexPath.row] ?? Action(title: "")
        cell.configure(withModel: action)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36.0
    }
}
