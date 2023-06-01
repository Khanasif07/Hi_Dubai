//
//  SuperYouHomeVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//


import UIKit
import SwiftUI

class SuperYouHomeVC: BaseVC {
    
    //MARK:- Variables
    var loadingView: LoadingView?
    @State var animals: [Animal] = Bundle.main.decode("animals.json")
    var statusBarHeight : CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
    let viewModel = SuperYouHomeVM()
    var shimmerStatus: ShimmerState = .applied
    var cellHeightDictionary: NSMutableDictionary = NSMutableDictionary()
    var collectionViewCachedPosition: [IndexPath: CGFloat] = [:]
    var isDataInitializeFromCache: Bool = false
    var talkRefHandlFlag: Bool = false
    var classRefHandleFlag: Bool = false
    var liveRefHandleFlag: Bool = false
    var tabBarHeight: CGFloat {
        return self.tabBarController?.tabBar.frame.size.height ?? 0.0
    }
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = AppColors.red
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    var checkFirstTime: Bool = true
    
    //MARK:- IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navContainerView: HeaderScrollingView!
    @IBOutlet weak var headerViewTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var dataTableViewTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var navBar: UpdatedTopNavigationBar!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var statusBarHC: NSLayoutConstraint!
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.viewModel.superYouData?.delegate = self
        //.....................................
//        addStatusBarBackgroundView(viewController: self)
        self.dataTableView.refreshControl = refresher
    }
    
    override func initialSetup() {
        self.navBar.delegate = self
        self.navBar.configureUI(isMainImage: true, isLeftButton: false, isRightButton: false)
        self.navBar.delegate = self
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        self.dataTableView.alpha = 1.0
        showLoader()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        statusBarHC.constant = statusBarHeight
        //        setUpBtn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkFirstTime = false
        self.dataTableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let superYouData = self.viewModel.superYouData, superYouData.titleData == nil {
            self.shimmerStatus = .toBeApply
        }
        
        checkFirstTime = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK:- Functions
    
    
    internal override func registerNibs() {
        self.dataTableView.registerCell(with: SuperYouTitleTableViewCell.self)
        self.dataTableView.registerCell(with: SuperViewCardTableViewCell.self)
        self.dataTableView.registerCell(with: NewsTableViewCell.self)
        self.dataTableView.registerHeaderFooter(with: TalksHomeTableHeader.self)
        self.showTableHeaderView()
    }
    
    private func showLoader(){
        if loadingView == nil{
            loadingView?.removeFromSuperview()
            //
            loadingView = LoadingView(frame: view.frame, inView: view)
            loadingView?.show()
            //
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
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
