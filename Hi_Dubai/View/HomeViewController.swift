//
//  HomeViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 27/05/2023.
//

import UIKit
import CarbonKit
class HomeViewController: BaseVC {
    //Notes:- header height == 325.0
    //  sticky height == 235.0
    var headerView = ArtistHeaderView.instanciateFromNib()
    var detailView = OtherArtistDetail.instanciateFromNib()
  
    var tabVC1    : StatsVC!
    var tabVC2     : StatsVC!
    var tabVC3   : StatsVC!
    var isProcess : Bool = false
    var lastOffset: CGFloat = 0.0
    var isFirstTime: Bool = true
    private var tabSwipe: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()

    @IBOutlet weak var baseViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var fakeNavBarHC: NSLayoutConstraint!
    @IBOutlet weak var fakeNavBar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "Home"
        self.statusBarStyle = .lightContent
        //
        setNavigationBar(title: "Home", subTitle: "Home", backButton: true, titleView: false, backButtonImage: UIImage(named: "back"), buttonTitle: "", largeTitles: true, leftTitle: "")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        setNavigationBarClear = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.baseViewHeight.constant = screen_height
        fakeNavBarHC.constant = (navigationController?.navigationBar.frame.size.height ?? 0.0) + (navigationController?.navigationBar.frame.origin.y ?? 0.0)
        view.layoutIfNeeded()
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        var frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        self.mainScrollView.frame = frame
//        self.mainScrollView.contentSize = frame.size
        frame = CGRect(x: 0, y: 325, width: screen_width, height: screen_height)
        frame.size.height = frame.size.height - (325)
        self.detailView.frame = frame
        scrollFrameSetup()
    }
    
    func initCarbonSwipeUI(targetView: UIView){
        let tabs: [String] = ["TRENDING", "WHAT'S NEW", "LATEST LISTS"]
        tabVC1 = StatsVC.instantiate(fromAppStoryboard: .Main)
        tabVC2 = StatsVC.instantiate(fromAppStoryboard: .Main)
        tabVC3 = StatsVC.instantiate(fromAppStoryboard: .Main)
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
    
    private func scrollFrameSetup() {
        self.setTheFrameOfViews()
    }
    
    
    ///SET THE FRAME OF VIEWS
    private func setTheFrameOfViews() {
    }
    
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
    
    
    private func parallelHeaderSetUp() {
        //TODO: Deprecated method to be change
        let parallexHeaderHeight = 325.0
        self.headerView.frame = CGRect(x: 0, y: 0, width: Int(screen_width), height: Int(parallexHeaderHeight))
        self.headerView.isUserInteractionEnabled = true
        self.mainScrollView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.HeaderDataSetUp()
    }
    
    private func instantiateViewController() {
        self.mainScrollView.addSubview(self.detailView)
        self.mainScrollView.addSubview(headerView)
        self.detailView.scrollView.isHidden = true
        initCarbonSwipeUI(targetView: self.detailView.containerView)
    }
    
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
//        CommonFunctions.shareWithActivityViewController(VC: self)
    }
    
    @objc func gotSearchPage() {
       //TODO -
    }
    
    private func setNavBar(_ scrollView: UIScrollView){
        let offsetY = scrollView.contentOffset.y
        if scrollView.isEqual(self.mainScrollView) {
            if offsetY > NAVBAR_CHANGE_POINT {
                let alpha:CGFloat = min(1, 1 - ((NAVBAR_CHANGE_POINT + 79 - offsetY) / 79))
                self.fakeNavBar.alpha = alpha
            } else {
                self.fakeNavBar.alpha = 0
            }
            
        }
    }
}

//MARK:- Move the screen and pages accroding to scroll
//====================================================

extension HomeViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(mainScrollView) && (!isProcess || isFirstTime){
            self.setNavBar(mainScrollView)
            if self.mainScrollView.contentOffset.y > 0.0 {
                let offsett =  self.mainScrollView.contentOffset.y >= 235.0 ? 235.0 : self.mainScrollView.contentOffset.y
                self.detailView.frame.size.height =  screen_height - (325) + offsett
                self.baseViewHeight.constant = mainScrollView.frame.size.height + offsett
                if self.mainScrollView.contentOffset.y >= 235.0 {
                    self.mainScrollView.setContentOffset(CGPoint(x: 0, y: 235.0), animated: false)
                }else{
                    self.mainScrollView.setContentOffset(CGPoint(x: 0, y: offsett), animated: false)
                }
                //==// smooth scrolling causing reason
                (tabSwipe.viewControllers[tabSwipe.currentTabIndex] as? StatsVC)?.mainTableView.setContentOffset(CGPoint(x: 0, y: offsett), animated: false)
                //==//
            }else{
                self.mainScrollView.setContentOffset(CGPoint(x: 0, y: 0.0), animated: false)
                //==// smooth scrolling causing reason
                (tabSwipe.viewControllers[tabSwipe.currentTabIndex] as? StatsVC)?.mainTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
                //==//
            }
        }else if scrollView.isEqual(mainScrollView){
            //==// smooth scrolling causing reason
            (tabSwipe.viewControllers[tabSwipe.currentTabIndex] as? StatsVC)?.mainTableView.setContentOffset(CGPoint(x: 0, y: lastOffset), animated: false)
            //==//
        }
        isProcess = false
        isFirstTime = false
    }
    
    @objc func enableScrolling(_ offset: CGFloat,_ isSearchHidden: Bool = true) {
        if !isProcess && offset > 0.0 {
            mainScrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
            print("detailView ScrollView.contentOffset.y:- \(offset)")
            detailView.frame.size.height =  screen_height - (325) + offset
            baseViewHeight.constant = mainScrollView.frame.size.height + offset
            print("----================----")
            print("Offset:- \(offset)")
            print("ScrollView Content Size:- \(mainScrollView.contentSize)")
            print("ScrollView Frame Size Height:- \(mainScrollView.frame.size.height)")
            print("ScrollView Content Offset Y:- \(mainScrollView.contentOffset.y)")
        }
        isProcess = false
    }
    
}

extension UIViewController {
    func embed(_ viewController:UIViewController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}


extension HomeViewController: CarbonTabSwipeNavigationDelegate{
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
//            isProcess =  true
            lastOffset = (carbonTabSwipeNavigation.viewControllers[0] as? StatsVC)?.mainTableView.contentOffset.y ?? 0.0
//            mainScrollView.setContentOffset(CGPoint(x: 0, y: 235), animated: false)
        case 1:
//            isProcess =  true
            lastOffset = (carbonTabSwipeNavigation.viewControllers[1] as? StatsVC)?.mainTableView.contentOffset.y ?? 0.0
//            mainScrollView.setContentOffset(CGPoint(x: 0, y: 235), animated: false)
        case 2:
//            isProcess =  true
            lastOffset = (carbonTabSwipeNavigation.viewControllers[2] as? StatsVC)?.mainTableView.contentOffset.y ?? 0.0
//            mainScrollView.setContentOffset(CGPoint(x: 0, y: 235), animated: false)
        default:
            break
        }
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, willMoveAt index: UInt) {
//        switch index {
//        case 0:
////            isProcess =  true
//            mainScrollView.setContentOffset(CGPoint(x: 0, y: 235), animated: false)
////            lastOffset = (carbonTabSwipeNavigation.viewControllers[0] as? StatsVC)?.mainTableView.contentOffset.y ?? 0.0
//        case 1:
//            isProcess =  true
//            mainScrollView.setContentOffset(CGPoint(x: 0, y: 235), animated: false)
////            lastOffset = (carbonTabSwipeNavigation.viewControllers[1] as? StatsVC)?.mainTableView.contentOffset.y ?? 0.0
//        case 2:
//            isProcess =  true
//            mainScrollView.setContentOffset(CGPoint(x: 0, y: 235), animated: false)
////            lastOffset = (carbonTabSwipeNavigation.viewControllers[2] as? StatsVC)?.mainTableView.contentOffset.y ?? 0.0
//        default:
//            break
//        }
    }
}
