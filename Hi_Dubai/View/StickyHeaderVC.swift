//
//  StickyHeaderVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 15/06/2023.
//

import UIKit
import MXParallaxHeader
import CarbonKit
class StickyHeaderVC: BaseVC {
    @IBOutlet weak var scrollView: MXScrollView!
    @IBOutlet weak var fakeNavBarHC: NSLayoutConstraint!
    @IBOutlet weak var fakeNavBar: UIImageView!
    
    private var tabSwipe: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    var headerView = ArtistHeaderView.instanciateFromNib()
    var detailView = OtherArtistDetail.instanciateFromNib()
    
    //MARK:- PROPERTIES
    //===================
    var maxValue: CGFloat = 1.0
    var minValue: CGFloat = 0.0
    var finalMaxValue: Int = 0
    var currentProgress: CGFloat = 0
    var currentProgressIntValue: Int = 0
    var isScrollingFirstTime: Bool = true
    var isProcess = false
    var lastOffset: CGFloat = 0.0
    var scrollToTop = false
    
    var tabVC1    : StatsVC!
    var tabVC2     : StatsVC!
    var tabVC3    : StatsVC!
    var tabVC4     : StatsVC!
    var tabVC5    : StatsVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "Home"
        self.statusBarStyle = .lightContent
        //
        setNavigationBar(title: "Home", subTitle: "Home", backButton: true, titleView: false, backButtonImage: UIImage(named: "Back Icon"), buttonTitle: "", largeTitles: true, leftTitle: "")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fakeNavBarHC.constant = (navigationController?.navigationBar.frame.size.height ?? 0.0) + (navigationController?.navigationBar.frame.origin.y ?? 0.0)
        view.layoutIfNeeded()
        //        let tabBarHeight    = (self.tabBarController?.tabBar.frame.size.height == nil) ? 70 : (self.tabBarController!.tabBar.frame.size.height)
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        var frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        self.scrollView.frame = frame
        self.scrollView.contentSize = frame.size
        frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        frame.size.height = frame.size.height - (self.scrollView.parallaxHeader.minimumHeight + statusBarHeight - 55.0)
        self.detailView.frame = frame
//        scrollFrameSetup()
        
    }
    
    //MARK:- PRIVATE FUNCTIONS
    //====================
    
    override func initialSetup() {
        super.initialSetup()
        self.parallelHeaderSetUp()
        self.HeaderDataSetUp()
        self.instantiateViewController()
        self.addButtonOnRight()
    }
    
    private func HeaderDataSetUp() {
        navTitle = "Home"
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.HeaderDataSetUp()
    }
    
    private func parallelHeaderSetUp() {
        //TODO: Deprecated method to be change
        let parallexHeaderHeight = 250.0
        let parallexHeaderMinHeight = (navigationController?.navigationBar.frame.size.height ?? 0.0) + (navigationController?.navigationBar.frame.origin.y ?? 0.0)// stack view hieght
        self.headerView.frame = CGRect(x: 0, y: 0, width: screen_width, height: parallexHeaderHeight)
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.headerView.widthAnchor.constraint(equalToConstant: screen_width).isActive = true
        self.headerView.isUserInteractionEnabled = true
        self.scrollView.delegate = self
        self.scrollView.parallaxHeader.minimumHeight = CGFloat(parallexHeaderMinHeight)
        self.scrollView.parallaxHeader.height = CGFloat(parallexHeaderHeight)
        self.scrollView.parallaxHeader.mode = MXParallaxHeaderMode.fill
        self.scrollView.parallaxHeader.delegate = self
        self.scrollView.parallaxHeader.view = self.headerView
    }
    
    
    func initCarbonSwipeUI(targetView: UIView){
        let tabs: [String] = ["TRENDING", "WHAT'S NEW", "LATEST LISTS", "REVIEW" ,"REWARDS"]
        tabVC1 = StatsVC.instantiate(fromAppStoryboard: .Main)
        tabVC2 = StatsVC.instantiate(fromAppStoryboard: .Main)
        tabVC3 = StatsVC.instantiate(fromAppStoryboard: .Main)
        tabVC4 = StatsVC.instantiate(fromAppStoryboard: .Main)
        tabVC5 = StatsVC.instantiate(fromAppStoryboard: .Main)
        tabSwipe.navigationController?.navigationBar.isHidden = true
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
    
    private func instantiateViewController() {
        
        self.detailView.scrollView.isHidden = true
       
        initCarbonSwipeUI(targetView: self.detailView.containerView)
        self.scrollView.addSubview(self.detailView)
        //        self.configureScrollView()
    }
    
}
extension StickyHeaderVC : MXParallaxHeaderDelegate ,MXScrollViewDelegate {
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
        print(parallaxHeader.progress)
        let prallexProgress = parallaxHeader.progress
        
        if isScrollingFirstTime && prallexProgress > 1.0 {
            maxValue = prallexProgress
            minValue = abs(1 - prallexProgress)
            finalMaxValue = Int(maxValue * 100)
            isScrollingFirstTime = false
        }
        
        fakeNavBar.alpha = (1.0 - prallexProgress)
        if prallexProgress  <= 0.05 {
            scrollToTop = true
            self.setNavigationBarClear = false
            self.addButtonOnRight(initial: false)
        } else {
            self.setNavigationBarClear = true
            scrollToTop = false
            self.addButtonOnRight()
        }
        
    }
    
    func scrollView(_ scrollView: MXScrollView, shouldScrollWithSubView subView: UIScrollView) -> Bool {
        return true
    }
    
    
}


extension StickyHeaderVC: CarbonTabSwipeNavigationDelegate{
    public func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {
        case 0:
            isProcess =  true
            return tabVC1 ?? UIViewController();
        case 1:
            isProcess =  true
            return tabVC2 ?? UIViewController();
        case 2:
            isProcess =  true
            return tabVC3 ?? UIViewController();
        case 3:
            isProcess =  true
            return tabVC4 ?? UIViewController();
        case 4:
            isProcess =  true
            return tabVC5 ?? UIViewController();
        default:
            break
        }
        return UIViewController()
    }
    
    public func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
        let parent = self.parent as? HomeViewController
        print("I'm on index \(String(describing: parent)) (Int(index))")
        switch index {
        case 0:
            isProcess =  true
            lastOffset = (carbonTabSwipeNavigation.viewControllers[0] as? StatsVC)?.mainTableView.contentOffset.y ?? 0.0
        case 1:
            isProcess =  true
            lastOffset = (carbonTabSwipeNavigation.viewControllers[1] as? StatsVC)?.mainTableView.contentOffset.y ?? 0.0
        case 2:
            isProcess =  true
            lastOffset = (carbonTabSwipeNavigation.viewControllers[2] as? StatsVC)?.mainTableView.contentOffset.y ?? 0.0
        case 3:
            isProcess =  true
            lastOffset = (carbonTabSwipeNavigation.viewControllers[1] as? StatsVC)?.mainTableView.contentOffset.y ?? 0.0
        case 4:
            isProcess =  true
            lastOffset = (carbonTabSwipeNavigation.viewControllers[2] as? StatsVC)?.mainTableView.contentOffset.y ?? 0.0
        default:
            break
        }
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, willMoveAt index: UInt) {
        isProcess =  true
    }
}


extension StickyHeaderVC {
    
    func addButtonOnRight(initial: Bool = true){
        let shareBtn : UIButton = UIButton.init(type: .custom)
        let img = UIImage.init(named: "iconfinder_cross-24_103181")?.withRenderingMode(.alwaysTemplate)
        shareBtn.setImage(img, for: .normal)
        shareBtn.tintColor = initial ? .white : UIColor.AppColor.changeBlack
        shareBtn.addTarget(self, action: #selector(gotSharePage), for: .touchUpInside)
        shareBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let shareButton = UIBarButtonItem(customView: shareBtn)
        let searchBtn : UIButton = UIButton.init(type: .custom)
        let img1 = UIImage.init(named: "iconfinder_cross-24_103181")?.withRenderingMode(.alwaysTemplate)
        searchBtn.setImage(img1, for: .normal)
        searchBtn.tintColor = initial ? .white : UIColor.AppColor.changeBlack
        searchBtn.addTarget(self, action: #selector(gotSearchPage), for: .touchUpInside)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let searchButton = UIBarButtonItem(customView: searchBtn)
        self.navigationItem.rightBarButtonItems = [searchButton,shareButton]
    }
    
    @objc func gotSharePage() {
    }
    
    @objc func gotSearchPage() {
    }
}
