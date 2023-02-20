//
//  ViewController.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit
class NewsListVC: UIViewController {
    //MARK:- IBoutlets
    @IBOutlet weak var newsTableView: UITableView!
    //MARK:- IBProperties
    lazy var viewModel = {
        NewsListViewModel()
    }()
    internal var selectedCell: NewsTableViewCell?
    internal var selectedCellImageViewSnapshot: UIView?
    internal var animator: Animator?
    private var indexPath: IndexPath?
    internal var currentShimmerStatus: ShimmerState = .toBeApply
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = indexPath{
            self.newsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    private func  initialSetup(){
        self.viewModel.delegate = self
        self.setUpTableView()
        self.fetchAPIData()
    }
    private func setUpTableView(){
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.newsTableView.separatorColor = .clear
        self.newsTableView.separatorStyle = .none
        self.newsTableView.registerCell(with: NewsTableViewCell.self)
        self.newsTableView.registerCell(with: ShimmerCell.self)
        self.newsTableView.enablePullToRefresh(tintColor: .orange, target: self, selector: #selector(refreshWhenPull(_:)))
    }
    private func fetchAPIData(){
        self.currentShimmerStatus = .toBeApply
        self.viewModel.getNewsListing()
    }
    private func presentSecondViewController(with data: Record) {
        let secondVC = NewsDetailVC.instantiate(fromAppStoryboard: .Main)
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .overCurrentContext
        secondVC.viewModel.newsModel = data
        present(secondVC, animated: true)
    }
    
    @objc func refreshWhenPull(_ sender: UIRefreshControl){
        sender.endRefreshing()
        self.fetchAPIData()
    }
}

//MARK:- Extension TableView Delegate and DataSource
extension NewsListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsData.isEmpty ? self.newsTableView.setEmptyMessage(self.viewModel.error?.localizedDescription ?? "") : self.newsTableView.restore()
        switch self.currentShimmerStatus {
        case .toBeApply:
            return 5
        case .applied:
            return self.viewModel.newsData.count
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.currentShimmerStatus {
        case .toBeApply:
            let cell = tableView.dequeueCell(with: ShimmerCell.self)
            return cell
        case .applied:
            let cell = tableView.dequeueCell(with: NewsTableViewCell.self)
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            return cell
        case .none:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.currentShimmerStatus == .applied {
            self.indexPath = indexPath
            selectedCell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell
            selectedCellImageViewSnapshot = selectedCell?.newsImgView.snapshotView(afterScreenUpdates: false)
            presentSecondViewController(with: viewModel.newsData[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.25) {
            cell?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.25) {
            cell?.transform = .identity
        }
    }
}

//MARK:- Extension NewsListViewModelDelegate
extension NewsListVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        DispatchQueue.main.async {
            self.currentShimmerStatus = .applied
            self.newsTableView.reloadData()
        }
    }
    
    func newsListingFailure(error: Error) {
        DispatchQueue.main.async {
            self.currentShimmerStatus = .none
            self.newsTableView.reloadData()
        }
    }
}
