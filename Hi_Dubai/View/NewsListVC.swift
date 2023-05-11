//
//  ViewController.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit
enum ScrollDirection : Int {
    case none
    case right
    case left
    case up
    case down
    case crazy
}

class NewsListVC: UIViewController {
    //MARK:- IBoutlets
    
    @IBOutlet weak var popularLbl: UILabel!
    @IBOutlet var businessHeader: UIView!
    @IBOutlet weak var newsTableView: UITableView!
    //MARK:- IBProperties
    lazy var viewModel = {
        NewsListViewModel()
    }()
    var emptyView: EmptyStateView? = EmptyStateView.instanciateFromNib()
    var emptyViewPersonal: EmptyView?
   
    internal var selectedCell: NewsTableViewCell?
    internal var selectedCellImageViewSnapshot: UIView?
    internal var animator: Animator?
    private var indexPath: IndexPath?
    internal var currentShimmerStatus: ShimmerState = .toBeApply
    var error: Error?
    
    //
    internal var containerViewMinY: Float = 0.0
    var lastContentOffset: CGFloat = 0.0
    internal var headerTitle: String = "POPULAR BUSINESS"
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        //
        self.popularLbl.text = headerTitle
        if #available(iOS 15.0, *) {
            newsTableView.sectionHeaderTopPadding = 0.0
        }
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                businessHeader.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
                businessHeader.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                businessHeader.layer.shadowOpacity = 1.0
                businessHeader.layer.shadowRadius = 3.0
            } else {
                businessHeader.layer.shadowColor = UIColor(white: 1.0, alpha: 0.3).cgColor
                businessHeader.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                businessHeader.layer.shadowOpacity = 1.0
                businessHeader.layer.shadowRadius = 3.0
            }
        }else {
            businessHeader.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
            businessHeader.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            businessHeader.layer.shadowOpacity = 1.0
            businessHeader.layer.shadowRadius = 3.0
        }
        newsTableView.isScrollEnabled = true
        businessHeader.backgroundColor = UIColor(named: "lightWhiteBlack")
        //
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = indexPath{
            self.newsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    private func  initialSetup(){
        self.viewModel.delegate = self
        self.emptyViewPersonal?.delegate = self
        self.setUpTableView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.fetchAPIData()
        })
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
        self.emptyView?.hide()
        self.currentShimmerStatus = .toBeApply
        self.newsTableView.reloadData()
        self.viewModel.getNewsListing()
    }
    private func presentSecondViewController(with data: Record) {
        let secondVC = NewsDetailVC.instantiate(fromAppStoryboard: .Main)
        secondVC.isBackBtnShow = true
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
        viewModel.newsData.isEmpty ? self.setEmptyMessage(self.viewModel.error?.localizedDescription ?? "",isTimeOutError: error?.errorCode == CustomError.timeOut.rawValue) : self.restore()
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
            switch indexPath.row {
            case 0:
                let vc = NewsDetailVC.instantiate(fromAppStoryboard: .Main)
                vc.isBackBtnShow = false
                vc.viewModel.newsModel = viewModel.newsData[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                self.indexPath = indexPath
                selectedCell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell
                selectedCellImageViewSnapshot = selectedCell?.newsImgView.snapshotView(afterScreenUpdates: false)
                presentSecondViewController(with: viewModel.newsData[indexPath.row])
            case 2:
                let vc = HomeVC.instantiate(fromAppStoryboard: .Main)
                vc.headerView.mainImgView.setImageFromUrl(ImageURL: viewModel.getCellViewModel(at: indexPath).postImageURL)
                self.navigationController?.pushViewController(vc, animated: false)
            case 3:
                let vc = SearchVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
            default:
                let vc = ExploreViewController.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
            }
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return businessHeader.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return businessHeader
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
        self.error = error
        DispatchQueue.main.async {
            self.currentShimmerStatus = .none
            self.newsTableView.reloadData()
        }
    }
}


extension NewsListVC{
    func setEmptyMessage(_ message: String,isTimeOutError: Bool = false) {
        // Custom way to add view
//        let frame = CGRect(x: 0, y: 0, width: newsTableView.frame.width, height: newsTableView.frame.height)
//        emptyView?.frame = frame
//        emptyView?.show()
//        newsTableView.backgroundView = emptyView
        
        
        // Custom way to add view
        if emptyViewPersonal != nil {
        } else{
            emptyViewPersonal = nil
            emptyViewPersonal = EmptyView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: self.view.frame.height)), inView: self.view, centered: true, icon: UIImage(named: ""), message: "")
            emptyViewPersonal?.delegate = self
            emptyViewPersonal?.show()
        }
        //        let titleLabel = UILabel()
        //        let messageLabel = UILabel()
        //        let retryButton = UIButton()
        //        retryButton.translatesAutoresizingMaskIntoConstraints = false
        //        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        //        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        //        titleLabel.textColor = UIColor.black
        //        retryButton.setTitle("Retry", for: .normal)
        //        retryButton.addTarget(self, action: #selector(retryBtnTapped), for: .touchDown)
        //        retryButton.setTitleColor(.red, for: .normal)
        //        retryButton.setTitleColor(.red, for: .selected)
        //        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        //        messageLabel.textColor = UIColor.lightGray
        //        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        //        emptyView.addSubview(titleLabel)
        //        emptyView.addSubview(messageLabel)
        //        emptyView.addSubview(retryButton)
        //        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        //        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        //        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        //        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 10).isActive = true
        //        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -10).isActive = true
        //
        //        retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10).isActive = true
        //        retryButton.leftAnchor.constraint(equalTo: messageLabel.leftAnchor, constant: 10).isActive = true
        //        retryButton.rightAnchor.constraint(equalTo: messageLabel.rightAnchor, constant: -10).isActive = true
        //        titleLabel.text = "You don't have any contact."
        //        messageLabel.text = message
        //        messageLabel.numberOfLines = 0
        //        messageLabel.textAlignment = .center
        //        emptyView.backgroundColor = .yellow
        //        emptyView.roundCorners([.allCorners], radius: 10.0)
        //        // The only tricky part is here:
        //        newsTableView.backgroundView = emptyView
        //        newsTableView.separatorStyle = .none
    }
    
//    @objc func retryBtnTapped(){
//        print("retry btn tapped.")
//        self.fetchAPIData()
//    }
    
    func restore() {
        newsTableView.backgroundView = nil
        emptyViewPersonal?.hide()
    }
}


extension NewsListVC{
    func enableGlobalScrolling(_ offset: CGFloat) {
        (self.parent as? SearchVC)?.enableScrolling(offset)
    }
    
    func scrollViewDidScroll(_ scroll: UIScrollView) {
        var scrollDirection: ScrollDirection

        if lastContentOffset > scroll.contentOffset.y {
            scrollDirection = .down
        } else {
            scrollDirection = .up
        }

        let offsetY = scroll.contentOffset.y
        var stopScroll: CGFloat = 85.0
        
        if UIDevice.current.hasNotch{
            stopScroll = 95.0
        }
//        if !filtersButtonsView.isHidden {
//            stopScroll = stopScroll - 10.0
//        }
        lastContentOffset = scroll.contentOffset.y
        
        if scrollDirection == .up {
            if offsetY < stopScroll {
                enableGlobalScrolling(offsetY)
            } else {
                enableGlobalScrolling(stopScroll)
            }
        } else if (scrollDirection == .down) && (offsetY < stopScroll) {
            enableGlobalScrolling(offsetY)
        }
        
//        if !isShowingLatest {
//            let currentOffset = Int(scroll.contentOffset.y)
//            let maximumOffset = Int(scroll.contentSize.height - scroll.frame.size.height)
//            if Double(maximumOffset - currentOffset) <= 80.0 && ((pageToDownload?.intValue ?? 0) + 1) * Int(ITEMS_PER_PAGE) == (searchResults?.count ?? 0) {
//                pageToDownload = NSNumber(value: (pageToDownload?.intValue ?? 0) + 1)
//                getData()
//            }
//        }
    }
}

extension NewsListVC: EmptyStateViewDelegate{
    func loginAction() {
        self.fetchAPIData()
    }
    
    func learnHowAction() {
        self.fetchAPIData()
    }
}
