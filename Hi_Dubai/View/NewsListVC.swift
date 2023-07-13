//
//  ViewController.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit
import FirebaseAnalytics
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
    
    var isShowSectionHeader: Bool = false
    var isPrefersLargeTitles: Bool = true
    var headerView = ArtistHeaderView.instanciateFromNib()
    var isScrollingTrue: Bool = true
    lazy var viewModel = {
        NewsListViewModel()
    }()
    var emptyView: EmptyStateView? = EmptyStateView.instanciateFromNib()
    var emptyViewPersonal: EmptyView?
    var loadingView: LoadingView?
    var isHitApiInProgress: Bool = true
   
    internal var selectedCell: NewsTableViewCell?
    internal var selectedCellImageViewSnapshot: UIView?
    internal var animator: Animator?
    private var indexPath: IndexPath?
    internal var currentShimmerStatus: ShimmerState = .toBeApply
    var error: Error?
    
    //
//    var stopScroll = 80.0
    internal var containerViewMinY: Float = 0.0
    var lastContentOffset: CGFloat = 0.0
    internal var headerTitle: String = "POPULAR BUSINESS"{
        didSet{
            if self.popularLbl != nil {
                self.popularLbl.text = headerTitle
            }
        }
    }
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
       
        self.navigationController?.navigationBar.prefersLargeTitles = isPrefersLargeTitles
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        newsTableView.isScrollEnabled = true
        title = "News"
        self.title = "123223"
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
        businessHeader.backgroundColor = UIColor(named: "lightWhiteBlack")
        //
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        if let indexPath = indexPath{
            self.newsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        newsTableView.isScrollEnabled = isScrollingTrue
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    private func  initialSetup(){
        self.setUpTableView()
        //
        loadingView = LoadingView(frame: view.frame, inView: view)
        loadingView?.show()
        //
        self.viewModel.delegate = self
        self.emptyViewPersonal?.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
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
//        self.headerSetup()
        self.newsTableView.enablePullToRefresh(tintColor: .orange, target: self, selector: #selector(refreshWhenPull(_:)))
    }
    
    private func headerSetup(){
        let parallexHeaderHeight = 250.0
        self.headerView.frame = CGRect(x: 0, y: 0, width: Int(screen_width), height: Int(parallexHeaderHeight))
        self.headerView.isUserInteractionEnabled = true
        self.newsTableView.tableHeaderView = self.headerView
    }
    
    private func fetchAPIData(){
        self.isHitApiInProgress = true
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
            return 0
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
                //
                let vc = SettingVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
               
//                AppRouter.checkSettingFlow(UIApplication.shared.currentWindow!)
            case 1:
                let vc = HomeVCC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
//                self.indexPath = indexPath
//                selectedCell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell
//                selectedCellImageViewSnapshot = selectedCell?.newsImgView.snapshotView(afterScreenUpdates: false)
//                presentSecondViewController(with: viewModel.newsData[indexPath.row])
            case 2:
                let vc = HomeVC.instantiate(fromAppStoryboard: .Main)
                vc.headerView.mainImgView.setImageFromUrl(ImageURL: viewModel.getCellViewModel(at: indexPath).postImageURL)
                self.navigationController?.pushViewController(vc, animated: false)
            case 3:
                let vc = SearchVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
            case 4:
                let vc = HotelResultVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
            case 5:
                let vc = ExploreViewController.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
            case 6:
                let vc = SuperSheVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
            case 7:
                let vc = SuperYouHomeVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
            case 8:
                let vc = FoodViewController()
                self.navigationController?.pushViewController(vc, animated: false)
            case 9:
                let vc = CompostionalLayoutVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
            case 10:
                let vc = NavigationTypeVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
            case 11:
                let vc = StickyHeaderVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
            case 12:
                let vc = NewsDiscoverVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: false)
            case 13:
                let vc = CategoryVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            case 14:
                let vc = AppsViewController()
//                let vc = BusinessCategoriesVC.instantiate(fromAppStoryboard: .Main)
//                let navController = UINavigationController(rootViewController: vc)
//                navController.isNavigationBarHidden = true
//
//                navController.modalPresentationStyle = .fullScreen
//                self.navigationController?.navigationBar.isHidden = true
//                self.navigationController?.navigationItem.title = "Hello"
//                self.navigationController?.present(navController, animated: false)
                self.navigationController?.pushViewController(vc, animated: true)
                
            default:
                let vc = MainDetailsTableViewController.instantiate(fromAppStoryboard: .Main)
                vc.newsModel = viewModel.newsData[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath){
//        let cell = tableView.cellForRow(at: indexPath)
//        UIView.animate(withDuration: 0.25) {
//            cell?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath){
//        let cell = tableView.cellForRow(at: indexPath)
//        UIView.animate(withDuration: 0.25) {
//            cell?.transform = .identity
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isShowSectionHeader ? businessHeader.frame.size.height : 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return businessHeader
    }
}

//MARK:- Extension NewsListViewModelDelegate
extension NewsListVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        self.isHitApiInProgress = false
        DispatchQueue.main.async {
            self.loadingView?.hide()
            self.loadingView?.removeFromSuperview()
            self.currentShimmerStatus = .applied
            self.newsTableView.reloadData()
        }
    }
    
    func newsListingFailure(error: Error) {
        self.isHitApiInProgress = false
        self.error = error
        DispatchQueue.main.async {
            self.currentShimmerStatus = .none
            self.newsTableView.reloadData()
        }
    }
}


extension NewsListVC{
    func setEmptyMessage(_ message: String = "",isTimeOutError: Bool = false) {
        // Custom way to add view
        var offset:CGFloat = 0
        var bottomOffset = 0.0
        var fakenavHeightRef:CGFloat = 0.0
        if #available(iOS 13.0, *) {
            let window:UIWindow! = UIApplication.shared.keyWindow
                fakenavHeightRef =  fakenavHeightRef + window.safeAreaInsets.top
                bottomOffset =  window.safeAreaInsets.bottom
        }else {
            let window:UIWindow! = UIApplication.shared.keyWindow
            fakenavHeightRef = fakenavHeightRef + window.safeAreaInsets.top
            bottomOffset =  window.safeAreaInsets.bottom
        }
        offset = self.navigationController?.navigationBar.height ?? 0.0
        
        // Custom way to add view
        if emptyViewPersonal == nil && !isHitApiInProgress{
            emptyViewPersonal?.removeFromSuperview()
            emptyViewPersonal = EmptyView(frame: CGRect(x: 0, y: fakenavHeightRef + offset, width: self.view.frame.width, height: self.view.frame.height -  fakenavHeightRef - offset - bottomOffset), inView: self.view, centered: true, icon: UIImage(named: ""), message: "")
            emptyViewPersonal?.delegate = self
            emptyViewPersonal?.show()
        }
    }
    
    func restore() {
        newsTableView.backgroundView = nil
        emptyViewPersonal?.hide()
        emptyViewPersonal?.removeFromSuperview()
        
    }
}


extension NewsListVC{
    func enableGlobalScrolling(_ offset: CGFloat,_ isSearchHidden: Bool = true) {
        (self.parent as? SearchVC)?.enableScrolling(offset,isSearchHidden)
//        (self.parent?.parent?.parent?.parent as? HomeVCC)?.enableScrolling(offset,isSearchHidden)
    }
    
    func scrollViewDidScroll(_ scroll: UIScrollView) {
        var scrollDirection: ScrollDirection
        var stopScroll = 80.0
        if lastContentOffset > scroll.contentOffset.y {
            scrollDirection = .down
        } else {
            scrollDirection = .up
        }
        
        let offsetY = scroll.contentOffset.y
        
        if UIDevice.current.hasNotch{
            stopScroll += 10.0
        }
        lastContentOffset = scroll.contentOffset.y
        
        if scrollDirection == .up {
            if offsetY < stopScroll {
                enableGlobalScrolling(offsetY)
            } else {
                enableGlobalScrolling(stopScroll,false)
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
        self.setEmptyMessage()
        self.fetchAPIData()
    }
    
    func learnHowAction() {
        self.setEmptyMessage()
        self.fetchAPIData()
    }
    
    //Grouped BY:-
}
