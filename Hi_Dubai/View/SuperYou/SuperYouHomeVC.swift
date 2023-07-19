//
//  SuperYouHomeVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//


import UIKit
import SwiftUI
import CarbonKit
class SuperYouHomeVC: BaseVC {
    //MARK:- Variables
    
    private var placesVC: RecentSearchVC?
//    private var placesView: PlacesAndSuperShesView?
    var loadingView: LoadingView?
    var searchTask: DispatchWorkItem?
    @State var animals: [Animal] = Bundle.main.decode("animals.json")
    var statusBarHeight : CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
    var cellType : [TableViewCell] = [.categories]
    let viewModel = SuperYouHomeVM()
    var shimmerStatus: ShimmerState = .applied
    var cellHeightDictionary: NSMutableDictionary = NSMutableDictionary()
//    var collectionViewCachedPosition: [IndexPath: CGFloat] = [:]
//    var isDataInitializeFromCache: Bool = false
    var tabBarHeight: CGFloat {
        return self.tabBarController?.tabBar.frame.size.height ?? 0.0
    }
    private var tabSwipe: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    var tabVC1: NewsListVC?
    var tabVC2: NewsListVC?
    var tabVC3: NewsListVC?
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = AppColors.red
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    var checkFirstTime: Bool = true
    
    //MARK:- IBOutlets
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var searchTxtFld: NewSearchTextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navContainerView: HeaderScrollingView!
    @IBOutlet weak var headerViewTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var dataTableViewTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var statusBarHC: NSLayoutConstraint!
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        self.cellType = (self.viewModel.superYouData?.tableCellAtIndexPath.randomElement())!
        self.navigationController?.navigationBar.isHidden = true
        self.viewModel.superYouData?.delegate = self
        searchTxtFld.delegate = self
        searchTxtFld.setPlaceholder(placeholder: "Find Malls, Shops, Hotels...")
        cancelBtn.isHidden = true
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(scrollToRowMethod), userInfo: nil, repeats: false)
        //.....................................
//        addStatusBarBackgroundView(viewController: self)
        self.dataTableView.refreshControl = refresher
    }
    
    override func initialSetup() {
        self.viewModel.delegate = self
        self.registerNibs()
        self.dataTableView.delegate = self
        self.dataTableView.dataSource = self
        self.dataTableView.alpha = 1.0
        if #available(iOS 15.0, *) {
            dataTableView.sectionHeaderTopPadding = 0.0
        }
        
        let navBarHeight: CGFloat = 44
        //imp...
        //        self.navContainerView.setup(constraint: headerViewTopConstraints, maxFollowPoint: navBarHeight + self.statusBarHeight, minFollowPoint: 0)
        self.navContainerView.setup(constraint: headerViewTopConstraints, maxFollowPoint: navBarHeight, minFollowPoint: 0)
        self.navContainerView.setupDelayPoints(pointOfStartingHiding: navBarHeight, pointOfStartingShowing: 0)
    }
    
    
    @objc func scrollToRowMethod(){
        if let index = self.viewModel.superYouData?.tableCellAtIndexPath.firstIndex(where: {$0 == cellType}){
            UIView.animate(withDuration: 0.5, delay: 0.0) {
                self.dataTableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: false)
            } completion: { value in
                if let cell = self.dataTableView.cellForRow(at: IndexPath(row: 0, section: index)) as? SuperViewCardTableViewCell{
                    if cell.cardCollectionView.numberOfItems(inSection: 0) > index {
                        cell.cardCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: false)
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        setNeedsStatusBarAppearanceUpdate()
        self.dataTableView.alpha = 1.0
        showLoader()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        statusBarHC.constant = statusBarHeight
        self.placesVC?.view.frame = CGRect(x: 0.0, y: statusBarHeight + navContainerView .frame.height, width: screen_width, height: screen_height -  (statusBarHeight + navContainerView.frame.height))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        checkFirstTime = false
        self.dataTableView.reloadData()
        tabVC1?.isScrollingTrue = false
        tabVC2?.isScrollingTrue = false
        tabVC3?.isScrollingTrue = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        checkFirstTime = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK:- Functions
    internal override func registerNibs() {
        self.dataTableView.registerCell(with: SuperYouCategoriesTableCell.self)
        self.dataTableView.registerCell(with: SuperYouPastLivTableCell.self)
        self.dataTableView.registerCell(with: SuperYouMusicTableCell.self)
        self.dataTableView.registerCell(with: SuperYouTitleTableViewCell.self)
        self.dataTableView.registerCell(with: SuperViewCardTableViewCell.self)
        self.dataTableView.registerHeaderFooter(with: TalksHomeTableHeader.self)
        self.showTableHeaderView()
    }
    
    func initCarbonSwipeUI(targetView: UIView){
        let tabs: [String] = ["TRENDING", "WHAT'S NEW", "LATEST LISTS"]
        tabVC1 = NewsListVC.instantiate(fromAppStoryboard: .Main)
        tabVC1?.isShowSectionHeader = true
        tabVC1?.isPrefersLargeTitles = false
        tabVC2 = NewsListVC.instantiate(fromAppStoryboard: .Main)
        tabVC2?.isShowSectionHeader = true
        tabVC2?.isPrefersLargeTitles = false
        tabVC3 = NewsListVC.instantiate(fromAppStoryboard: .Main)
        tabVC3?.isShowSectionHeader = true
        tabVC3?.isPrefersLargeTitles = false
//        tabSwipe.navigationController?.navigationBar.isHidden = true
        tabSwipe = CarbonTabSwipeNavigation(items: tabs, delegate: self)
        
        tabSwipe.tabBarController?.tabBar.tintColor = .black
        tabSwipe.setTabBarHeight(50.0)
        tabSwipe.toolbar.tintColor = .black
        tabSwipe.setIndicatorHeight(2.5)
        tabSwipe.delegate = self
        tabSwipe.toolbar.isTranslucent = false
        tabSwipe.setIndicatorColor(UIColor.blue)
        tabSwipe.view.backgroundColor = .clear
        tabSwipe.insert(intoRootViewController: self,andTargetView: targetView)
        for i in 0..<tabs.count {
            let screenRect = UIScreen.main.bounds
            let width = CGFloat(screenRect.size.width / CGFloat(tabs.count))
            tabSwipe.carbonSegmentedControl?.setWidth(width, forSegmentAt: i)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.pop()
    }
    
    @IBAction func cancelSearch(_ sender: Any?) {
        self.cancelBtn.isHidden = true
        closeSearchingArea(true)
        removeChildrenVC()
        self.view.endEditing(true)
    }
    
    private  func addSeachTableView(){
//        self.placesView = PlacesAndSuperShesView(frame: CGRect(x: 0.0, y: 0.0, width: screen_width, height: self.view.bounds.height))
//
//        if let placeView = self.placesView {
//            placeView.screenUsingFor = .places
//            self.view.addSubview(placeView)
//        }
        if !(self.children.last is RecentSearchVC) {
            self.placesVC = RecentSearchVC.instantiate(fromAppStoryboard: .Main)
            placesVC?.placesView?.isScrollEnabled = true
            placesVC?.screenUsingFor = .supershes
//            removeChildrenVC()
            placesVC?.view.frame = CGRect(x: 0.0, y: statusBarHeight + navContainerView .frame.height, width: screen_width, height: screen_height -  (statusBarHeight + navContainerView.frame.height))
            self.view.addSubview(placesVC!.view)
            addChild(placesVC!)
        }
    }
    
    func removeChildrenVC() {
        for vc in children {
            if vc is RecentSearchVC {
                vc.willMove(toParent: nil)
                vc.view.removeFromSuperview()
                vc.removeFromParent()
            }
        }
        //        for view in containerView?.subviews ?? [] {
        //            view.removeFromSuperview()
        //        }
    }
    
    private func showLoader(){
        if loadingView == nil{
            loadingView?.removeFromSuperview()
            //
            loadingView = LoadingView(frame: view.frame, inView: view)
            loadingView?.show()
            //
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.loadingView?.hide()
            self.loadingView?.removeFromSuperview()
        })
    }
   
    func showTableHeaderView() {
        let containerView = UIView()
        containerView.backgroundColor = AppColors.black
        let childView = UIHostingController(rootView: TabGalleryView())
        self.containerView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: screen_width, height: 245.0))
        childView.view.frame = self.containerView.bounds
        addChild(childView)
        childView.view.backgroundColor = .clear
        containerView.addSubview(childView.view)
        childView.didMove(toParent: self)
        self.dataTableView.tableHeaderView = containerView
        self.dataTableView.tableHeaderView?.height = 245.0
    }
    
    
    //MARK:- IBActions
    
    
    @objc func pullToRefresh() {
        self.hitApi()
        let deadline = DispatchTime.now() + .milliseconds(700)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.refresher.endRefreshing()
        }
    }
    
    @objc func hitApi() {
        self.viewModel.superYouData?.dataMappingInModel(jsonArr: [])
    }
  
}

//MARK:- Extension NewsListViewModelDelegate
extension SuperYouHomeVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
    
    func newsListingFailure(error: Error) {
        //        self.error = error
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
}


extension UIViewController {
    func addStatusBarBackgroundView(viewController: UIViewController) -> Void {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIDevice.width, height:UIDevice.topSafeArea))
        let view : UIView = UIView.init(frame: rect)
        view.backgroundColor = UIColor.black
        viewController.view?.addSubview(view)
    }
}

extension SuperYouHomeVC: UpdatedTopNavigationBarDelegate{
    func leftButtonAction() {
        self.pop()
    }
}


// MARK: - WalifSearchTextFieldDelegate
extension SuperYouHomeVC: WalifSearchTextFieldDelegate{
    func walifSearchTextFieldBeginEditing(sender: UITextField!) {
        addSeachTableView()
        self.cancelBtn.isHidden = false
        closeSearchingArea(false)
    }
    
    func walifSearchTextFieldEndEditing(sender: UITextField!) {
        closeSearchingArea(true)
    }
    
    func walifSearchTextFieldChanged(sender: UITextField!) {
        addSeachTableView()
        let searchValue = sender.text ?? ""
        self.searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            guard let `self` = self else { return }
            self.placesVC?.placesView?.searchValue = searchValue
            self.placesVC?.screenUsingFor = .searchMovie
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
    }
    
    func walifSearchTextFieldIconPressed(sender: UITextField!) {
        closeSearchingArea(true)
        self.searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            guard let `self` = self else { return }
            self.placesVC?.placesView?.searchValue = ""
            self.placesVC?.screenUsingFor = .supershes
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
    }
    
    func closeSearchingArea(_ isTrue: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0.1,options: .curveEaseInOut) {
            self.searchTxtFld.crossBtnWidthConstant.constant = isTrue ? 0.0 : 50.0
            self.view.layoutIfNeeded()
        } completion: { value in
            self.searchTxtFld.cancelBtn.isHidden = isTrue
            self.view.layoutIfNeeded()
        }
    }
    
}

extension SuperYouHomeVC: CarbonTabSwipeNavigationDelegate{
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {
        case 0:
            tabVC1?.isScrollingTrue = false
            return tabVC1 ?? UIViewController();
        case 1:
            tabVC2?.isScrollingTrue = false
            return tabVC2 ?? UIViewController();
        case 2:
            tabVC3?.isScrollingTrue = false
            return tabVC3 ?? UIViewController();
        default:
            break
        }
        return UIViewController()
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
        let tabs: [String] = ["TRENDING", "WHAT'S NEW", "LATEST LISTS"]
        let parent = self.parent as? SuperYouHomeVC
        print("I'm on index \(parent) (Int(index))")
        switch index {
        case 0:
            (carbonTabSwipeNavigation.viewControllers[0] as? NewsListVC)?.newsTableView.backgroundColor = .clear
            (carbonTabSwipeNavigation.viewControllers[0] as? NewsListVC)?.headerTitle = tabs[Int(index)]
        case 1:
            (carbonTabSwipeNavigation.viewControllers[1] as? NewsListVC)?.newsTableView.backgroundColor = .clear
            (carbonTabSwipeNavigation.viewControllers[1] as? NewsListVC)?.headerTitle = tabs[Int(index)]
        case 2:
            (carbonTabSwipeNavigation.viewControllers[2] as? NewsListVC)?.newsTableView.backgroundColor = .clear
            (carbonTabSwipeNavigation.viewControllers[2] as? NewsListVC)?.headerTitle = tabs[Int(index)]
        default:
            break
        }
    }
    
    
}
