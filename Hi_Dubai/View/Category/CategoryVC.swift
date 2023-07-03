//
//  CategoryVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 03/07/2023.
//

import UIKit

protocol HeplerDelegate {
    func heightChanged()
    func cellAdded()
    func cellDeleted()
}

class CategoryVC: UIViewController {

    var hiddenSections = Set<Int>()
    @IBOutlet weak var dataTableView: CustomTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        dataTableView.separatorStyle = .none
        dataTableView.backgroundColor =  UIColor.clear
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }


}

private extension CategoryVC {
    func commonInit() {
        setUI()
        setConstraints()
    }

    func setUI() {
        dataTableView.dataSource = self
        dataTableView.delegate = self
        dataTableView.registerCell(with: CategoryTitleCell.self)
        self.view.backgroundColor = UIColor.clear
    }

    func setConstraints() {
//        tableView.edgesToSuperview(usingSafeArea: true)
    }
}


//MARK: Tableview delegates
extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: CategoryTitleCell.self)
        cell.selectedIndexPath = indexPath
        cell.configure(withModel: sample[indexPath.row])
        cell.internalTableView.isHidden = !(hiddenSections.contains(indexPath.row))
        cell.buttonTapped = { [weak self] (btn) in
            guard let `self` = self else { return }
            viewMoreSelected = false
            cell.internalTableView.isHidden = !cell.internalTableView.isHidden
            cell.isRowShow = !cell.internalTableView.isHidden
            hideSection(section: indexPath.row,cell: cell)
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
        return UITableView.automaticDimension
    }
    
    private func hideSection(section: Int,cell: CategoryTitleCell) {
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
        } else {
            if let sectionn = self.hiddenSections.first{
                self.hiddenSections.remove(sectionn)
                if let cells = dataTableView.cellForRow(at: IndexPath(row: sectionn, section: 0)) as? CategoryTitleCell{
                    cells.internalTableView.isHidden = true
                }
            }
            self.hiddenSections.insert(section)
        }
    }
}

extension CategoryVC: HeplerDelegate {
    func heightChanged() {
        dataTableView.performBatchUpdates(nil)
    }

    func cellAdded() {

    }

    func cellDeleted() {

    }
}
class CustomTableView:UITableView{
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

