//
//  ViewController.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit
import PreviewTransition
class NewsListVC: UIViewController {

    //MARK:- IBoutlets
    @IBOutlet weak var newsTableView: UITableView!
    var viewModel = NewsListViewModel()
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    private func  initialSetup(){
        self.setUpTableView()
        self.gitNewsListingApi()
    }
    private func setUpTableView(){
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.newsTableView.registerCell(with: NewsTableViewCell.self)
    }
    private func gitNewsListingApi(){
        self.viewModel.delegate = self
        self.viewModel.getNewsListing()
    }
}

//MARK:- Extension TableView Delegate and DataSource
extension NewsListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsData.isEmpty ? self.newsTableView.setEmptyMessage("News is not available") : self.newsTableView.restore()
        return self.viewModel.newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell()}
        cell.populateCell(viewModel.newsData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailVC.instantiate(fromAppStoryboard: .Main)
        vc.viewModel.newsModel = self.viewModel.newsData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Extension NewsListViewModelDelegate
extension NewsListVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
    func newsListingFailure(error: Error) {
        self.newsTableView.reloadData()
        self.showAlert(msg: error.localizedDescription)
    }
}
