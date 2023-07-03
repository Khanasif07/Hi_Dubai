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

   
    @IBOutlet weak var dataTableView: UITableView!
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
        cell.helperDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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

extension UITableView {
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
