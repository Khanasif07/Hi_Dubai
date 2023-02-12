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
    var viewModel = NewsListViewModel()
    var selectedCell: NewsTableViewCell?
    var selectedCellImageViewSnapshot: UIView?
    var animator: Animator?
    var indexPath: IndexPath?
    var activity : SpinnerViewController?
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
        self.newsTableView.registerCell(with: NewsTableViewCell.self)
        self.newsTableView.enablePullToRefresh(tintColor: .orange, target: self, selector: #selector(refreshWhenPull(_:)))
    }
    private func fetchAPIData(){
        self.createSpinnerView()
        self.viewModel.getNewsListing()
    }
    private func presentSecondViewController(with data: Record) {
        let secondVC = NewsDetailVC.instantiate(fromAppStoryboard: .Main)
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .overCurrentContext
        secondVC.viewModel.newsModel = data
        present(secondVC, animated: true)
    }
    private func createSpinnerView() {
        activity = SpinnerViewController()
        addChild(activity!)
        activity?.view.frame = view.frame
        view.addSubview(activity!.view)
        activity?.didMove(toParent: self)
    }
    private func removeSpinnerView(){
        activity?.willMove(toParent: nil)
        activity?.view.removeFromSuperview()
        activity?.removeFromParent()
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
        return self.viewModel.newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: NewsTableViewCell.self)
        cell.populateCell(viewModel.newsData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        selectedCell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell
        selectedCellImageViewSnapshot = selectedCell?.newsImgView.snapshotView(afterScreenUpdates: false)
        presentSecondViewController(with: viewModel.newsData[indexPath.row])
    }
}

//MARK:- Extension NewsListViewModelDelegate
extension NewsListVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        DispatchQueue.main.async {
            self.removeSpinnerView()
            self.newsTableView.reloadData()
        }
    }
    
    func newsListingFailure(error: Error) {
        DispatchQueue.main.async {
            self.removeSpinnerView()
            self.newsTableView.reloadData()
        }
    }
}
