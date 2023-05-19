//
//  SuperYouHomeVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//


import UIKit
import AVKit
import AVFoundation



class SuperYouHomeVC: BaseVC {
    
    //MARK:- Variables
    
    //    let localData = DataCache.instance.readObject(forKey: "SuperYouHome")
    let viewModel = SuperYouHomeVM()
    var shimmerStatus: ShimmerState = .applied
    var cellHeightDictionary: NSMutableDictionary = NSMutableDictionary()
    var collectionViewCachedPosition: [IndexPath: CGFloat] = [:]
    var isDataInitializeFromCache: Bool = false
    var talkRefHandlFlag: Bool = false
    var classRefHandleFlag: Bool = false
    var liveRefHandleFlag: Bool = false
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
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
    @IBOutlet weak var newPostBtn: AppButton!
    @IBOutlet weak var newPostBtnWidthOutlet: NSLayoutConstraint!
    @IBOutlet weak var newPostBtnTopConstraints: NSLayoutConstraint!
    
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.viewModel.superYouData?.delegate = self
        //.....................................
        addStatusBarBackgroundView(viewController: self)
        self.dataTableView.refreshControl = refresher
    }
    
    override func initialSetup() {
        self.navBar.delegate = self
        self.navBar.configureUI(isMainImage: true, isLeftButton: true, isRightButton: false)
        self.navBar.delegate = self
        self.viewModel.delegate = self
        self.registerNibs()
        self.dataTableView.delegate = self
        self.dataTableView.dataSource = self
        self.dataTableView.alpha = 1.0
        if #available(iOS 15.0, *) {
            dataTableView.sectionHeaderTopPadding = 0.0
        }
//        self.dataTableView.refreshBlock = { [weak self] in
//            self?.pullToRefresh()
//        }
        
        let navBarHeight: CGFloat = 44
        //imp...
        //        self.navContainerView.setup(constraint: headerViewTopConstraints, maxFollowPoint: navBarHeight + self.statusBarHeight, minFollowPoint: 0)
        self.navContainerView.setup(constraint: headerViewTopConstraints, maxFollowPoint: navBarHeight, minFollowPoint: 0)
        self.navContainerView.setupDelayPoints(pointOfStartingHiding: 44, pointOfStartingShowing: 0)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.shimmerStatus == .applied, self.viewModel.superYouData != nil {
            if self.viewModel.superYouData != nil {
                
                self.dataTableView.alpha = 1.0
                
                //                self.navBar.rightImageView.setImage(imageString: UserModel.main.profilePicture, localUri: AppUserDefaults.value(forKey: .profilePlaceHolder).string ?? "", placeHolderImage: nil, imageQuality: .low,isWhiteBorder: true)
                
                if let cell = self.dataTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SuperYouTitleTableViewCell, let dataSource = self.viewModel.superYouData?.titleData {
                    //                    cell.configureCell(startTitle: dataSource.topTitle, firstName: UserModel.main.firstName, subtitle: dataSource.bottomTtitle)
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //        setUpBtn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkFirstTime = false
        self.dataTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        if let cell = self.dataTableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? SuperYouVideoTableViewCell, self.viewModel.superYouData != nil {
        //            cell.playVideo()
        //        }
        //
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
    }
    
    func showShimmerAndHitApi() {
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
    
    func newPostBtnAnimationSetUp(isStart: Bool) {
        if isStart {
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let `self` = self else { return }
                self.newPostBtnWidthOutlet.constant = 34.5
                self.newPostBtn.superview?.layoutIfNeeded()
            }
        } else {
            self.newPostBtnWidthOutlet.constant = 90
            self.newPostBtn.isHidden = true
        }
    }
    
    func newPostBtnScrollingAnimation(_ scrollView: UIScrollView, topConstraintsValue: CGFloat) {
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let `self` = self else { return }
            if scrollView.contentOffset.x > topConstraintsValue {
                //                self.newPostBtnTopConstraints.constant = 77.0
                self.newPostBtn.superview?.layoutIfNeeded()
                
            } else {
                //                self.newPostBtnTopConstraints.constant = topConstraintsValue
                self.newPostBtn.superview?.layoutIfNeeded()
            }
        }
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
