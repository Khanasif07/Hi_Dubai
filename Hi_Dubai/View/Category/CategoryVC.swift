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
        cell.configure(withModel: sample[indexPath.row])
        cell.internalTableView.isHidden = !(hiddenSections.contains(indexPath.row))
        cell.buttonTapped = { [weak self] (btn) in
            guard let `self` = self else { return }
            cell.internalTableView.isHidden = !cell.internalTableView.isHidden
            cell.isRowShow = !cell.internalTableView.isHidden
            hideSection(section: indexPath.row)
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
    
    private func hideSection(section: Int) {
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
        } else {
            if let sectionn = self.hiddenSections.first{
//                dataTableView.beginUpdates()
                self.hiddenSections.remove(sectionn)
//                dataTableView.performBatchUpdates(nil)
            }
//            dataTableView.beginUpdates()
            self.hiddenSections.insert(section)
//            dataTableView.performBatchUpdates(nil)
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

