//
//  NewsDetailVC.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit
import ParallaxHeader
class NewsDetailVC: BaseViewController {
    //MARK:- IBoutlets
    @IBOutlet weak var mainTableViewTopConst: NSLayoutConstraint!
    @IBOutlet weak var mainTableView: UITableView!
    //MARK:- IBProperties
    var viewModel: NewsDetailViewModel = NewsDetailViewModel()
    lazy var headerView: HeaderView = {
        let view = UINib(nibName: "HeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! HeaderView
        return view
    }()
    var isBackBtnShow: Bool = true
    var backButton: UIButton?

    
    init(user: Record) {
        self.viewModel.newsModel = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel.newsModel = nil

    }

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
        mainTableViewTopConst.constant = -(UIApplication.shared.currentWindow?.safeAreaInsets.top ?? 0.0)
        headerView.topContainerHeight?.constant = UIScreen.main.bounds.width * 1.25
        headerView.backBtnTopConst?.constant = (UIApplication.shared.currentWindow?.safeAreaInsets.top ?? 0.0)
        positionHeaderView()
    }
    
    private func positionHeaderView() {
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        headerView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    private func setUpTableView(){
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.registerCell(with: NewsDetailTableCell.self)
    }
    
    private func parallelHeaderSetUp() {
        let HeaderHight = CGFloat(UIScreen.main.bounds.width * 1.25)
        let parallexHeaderMinHeight = 125.0
        self.mainTableView.parallaxHeader.view = self.headerView
        self.mainTableView.parallaxHeader.minimumHeight = parallexHeaderMinHeight
        self.mainTableView.parallaxHeader.height = HeaderHight
        self.mainTableView.parallaxHeader.mode = ParallaxHeaderMode.fill
        if #available(iOS 11.0, *) {
            mainTableView.contentInsetAdjustmentBehavior = .always
        }
    }
    
    private func headerViewDataSetup(){
        self.headerView.backBtn.isHidden = !isBackBtnShow
        self.headerView.backBtn.addTarget(self, action: #selector(self.backButtonHandler), for: .touchUpInside)
        self.headerView.playerImageView.setImageFromUrl(ImageURL: self.viewModel.newsModel?.postImageURL ?? "")
        self.headerView.tagLbl.text = self.viewModel.newsModel?.primaryTag ?? ""
    }
    //MARK: - Navigator
    private func handleLoginButtonTap() {
//            performLogin { [weak self] result in
//                switch result {
//                case .success(let user):
//                    self?.navigator.navigate(to: .loginCompleted(user: user))
//                case .failure(let error):
//                    self?.show(error)
//                }
//            }
        }

        private func handleForgotPasswordButtonTap() {
//            navigator?.navigate(to: .forgotPassword)
        }

        private func handleSignUpButtonTap() {
//            navigator?.navigate(to: .signup)
        }
    //
}

//MARK:- Extension TableView Delegate and DataSource
extension NewsDetailVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: NewsDetailTableCell.self)
        let cellVM = viewModel.getCellViewModel()
        cell.cellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: actions
extension NewsDetailVC {
    @objc func backButtonHandler() {
        dismiss(animated: true)
    }
}
