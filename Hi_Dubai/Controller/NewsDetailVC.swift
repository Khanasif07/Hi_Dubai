//
//  NewsDetailVC.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit
import ParallaxHeader
class NewsDetailVC: UIViewController {
    //MARK:- IBoutlets
    @IBOutlet weak var mainTableView: UITableView!
    var viewModel: NewsDetailViewModel = NewsDetailViewModel()
    lazy var headerView: HeaderView = {
        let view = UINib(nibName: "HeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! HeaderView

        return view
    }()
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup(){
        setUpTableView()
        parallelHeaderSetUp()
        headerViewDataSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.topContainerHeight?.constant = UIScreen.main.bounds.width * 1.272 - 66.0
        positionHeaderView()
    }
    
    private func positionHeaderView() {
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        headerView.frame.size = size
    }
    
    private func setUpTableView(){
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.registerCell(with: NewsDetailTableCell.self)
    }
    
    private func parallelHeaderSetUp() {
        let HeaderHight = CGFloat(UIScreen.main.bounds.width * 1.272 - 66.0)
        let parallexHeaderMinHeight = self.navigationController?.navigationBar.bounds.height ?? 74
        self.headerView.playerImageView.translatesAutoresizingMaskIntoConstraints = false
        self.mainTableView.sectionHeaderHeight = CGFloat.leastNormalMagnitude
        self.mainTableView.parallaxHeader.view = self.headerView
        self.mainTableView.parallaxHeader.minimumHeight = parallexHeaderMinHeight
        self.mainTableView.parallaxHeader.height = HeaderHight
        self.mainTableView.parallaxHeader.mode = ParallaxHeaderMode.fill
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            mainTableView.contentInsetAdjustmentBehavior = .always
        }
    }
    
    private func headerViewDataSetup(){
        self.headerView.playerImageView.setImageFromUrl(ImageURL: self.viewModel.newsModel?.postImageURL ?? "")
        self.headerView.tagLbl.text = self.viewModel.newsModel?.primaryTag ?? ""
    }
    
}

//MARK:- Extension TableView Delegate and DataSource
extension NewsDetailVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailTableCell", for: indexPath) as? NewsDetailTableCell else { return UITableViewCell()}
        cell.populateCell(viewModel.newsModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
