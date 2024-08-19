//
//  HomeComingVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 20/05/2024.
//

import UIKit


class HomeComingVC: BaseVC {

    //MARK:- PROPERTIES
    //===================
    var maxValue: CGFloat = 1.0
    var minValue: CGFloat = 0.0
    var finalMaxValue: Int = 0
    var currentProgress: CGFloat = 0
    var currentProgressIntValue: Int = 0
    var isScrollingFirstTime: Bool = true
    
    var headerView = OtherArtistHeaderView.instanciateFromNib()
    var detailView = OtherArtistDetail.instanciateFromNib()
  
    var statsVC    : StatsVC!
    var newsVC     : StatsVC!
   
    var artistSymbol: String = "ARIG"
    private var scrollToTop: Bool = false
    
    //MARK:- IBOUTLETS
    //====================
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomDataViewHeightCost: NSLayoutConstraint!
    @IBOutlet weak var mainScrollView: UIScrollView!
    //MARK:- VIEW LIFE CYCLE
    //====================
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "Home"
//        self.statusBarStyle = .lightContent
        //
//        setNavigationBar(title: "Home", subTitle: "Home", backButton: true, titleView: false, backButtonImage: UIImage(named: "Back Icon"), buttonTitle: "", largeTitles: true, leftTitle: "")
        //
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.statusBarStyle = .lightContent
//        self.navigationController?.navigationBar.isHidden = false
        //MARK: - it is causing the issue of naviagtion bar title and buttons
//        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        fakeNavBarHC.constant = (navigationController?.navigationBar.frame.size.height ?? 0.0) + (navigationController?.navigationBar.frame.origin.y ?? 0.0)
        //        view.layoutIfNeeded()
        //        let tabBarHeight    = (self.tabBarController?.tabBar.frame.size.height == nil) ? 70 : (self.tabBarController!.tabBar.frame.size.height)
        //        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        var frame = CGRect(x: 0, y: 59.0, width: screen_width-59.0, height: screen_height)
        self.mainScrollView.frame = frame
        self.mainScrollView.contentSize = frame.size
        frame = CGRect(x: 0, y: 0, width: screen_width, height: (screen_height - 59.0 - 44.0 - 44.0 - 34.0))
        frame.size.height = screen_height
        self.detailView.frame = frame
        scrollFrameSetup()
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.HeaderDataSetUp()
    }
    
    private func parallelHeaderSetUp() {
        bottomDataViewHeightCost.constant = screen_height - 59.0 - 44.0 - 44.0 - 34.0
        //TODO: Deprecated method to be change
        let parallexHeaderHeight = 250.0
//        let parallexHeaderMinHeight = (navigationController?.navigationBar.frame.size.height ?? 0.0) + (navigationController?.navigationBar.frame.origin.y ?? 0.0) + 55.0// stack view hieght
        self.headerView.frame = CGRect(x: 0, y: 0, width: screen_width, height: parallexHeaderHeight)
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.headerView.widthAnchor.constraint(equalToConstant: screen_width).isActive = true
        self.headerView.heightAnchor.constraint(equalToConstant: parallexHeaderHeight).isActive = true
        self.headerView.isUserInteractionEnabled = true
        self.mainScrollView.delegate = self
//        self.mainScrollView.parallaxHeader.minimumHeight = CGFloat(parallexHeaderMinHeight)
//        self.mainScrollView.parallaxHeader.height = CGFloat(parallexHeaderHeight)
//        self.mainScrollView.parallaxHeader.mode = MXParallaxHeaderMode.fill
//        self.mainScrollView.parallaxHeader.delegate = self
        self.headerView.delegate = self
//        self.mainScrollView.parallaxHeader.view = self.headerView
//        mainScrollView.addSubview(headerView)
    }
    
    private func scrollFrameSetup() {
        self.setTheFrameOfViews()
    }
    
    private func configureScrollView() {
        self.detailView.scrollView.contentSize = CGSize(width: screen_width * 2.0, height: 1.0)
    }
    
    private func HeaderDataSetUp() {
        navTitle = "Home"
    }
    
    @objc func enableScrolling(_ offset: CGFloat,_ isSearchHidden: Bool = true) {
//        if !isProcess && offset > 0.0 {
//            mainScrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
//            print("detailView ScrollView.contentOffset.y:- \(offset)")
//            detailView.frame.size.height =  screen_height - (325) + offset
//            baseViewHeight.constant = mainScrollView.frame.size.height + offset
            print("----================----")
//            print("Offset:- \(offset)")
//            print("ScrollView Content Size:- \(mainScrollView.contentSize)")
//            print("ScrollView Frame Size Height:- \(mainScrollView.frame.size.height)")
//            print("ScrollView Content Offset Y:- \(mainScrollView.contentOffset.y)")
//        }
//        isProcess = false
    }
    
    
    ///SET THE FRAME OF VIEWS
    private func setTheFrameOfViews() {

      let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 64
      let vcHeight = screen_height
        
        self.statsVC.view.frame = CGRect(x: 0, y: 0, width: screen_width, height: vcHeight)
        self.newsVC.view.frame = CGRect(x: screen_width, y: 0, width: screen_width, height: vcHeight)
//        self.musicVC.view.frame = CGRect(x: screen_width * 2, y: 0, width: screen_width, height: vcHeight)
//        self.socialVC.view.frame = CGRect(x: screen_width * 3, y: 0, width: screen_width, height: vcHeight)
//        self.eventsVC.view.frame = CGRect(x: screen_width * 4, y: 0, width: screen_width, height: vcHeight)

    }
    
    private func instantiateViewController() {
//        self.detailView.translatesAutoresizingMaskIntoConstraints = false
//        self.detailView.heightAnchor.constraint(equalToConstant: screen_height).isActive = true
//        self.detailView.widthAnchor.constraint(equalToConstant: screen_width).isActive = true
        self.detailView.scrollView.delegate = self
        self.bottomView.addSubview(self.detailView)
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 70
        let vcHeight = (screen_height - 59.0 - 44.0 - 44.0 - 34.0)

        self.statsVC = StatsVC.instantiate(fromAppStoryboard: .Main)
        self.addChild(statsVC)
        self.statsVC.view.frame = CGRect(x: 0, y: 0, width: screen_width, height: vcHeight )
        self.detailView.scrollView.frame = self.statsVC.view.frame
        self.detailView.scrollView.addSubview(self.statsVC.view)
        self.statsVC.didMove(toParent: self)
        
        self.newsVC = StatsVC.instantiate(fromAppStoryboard: .Main)
        self.addChild(self.newsVC)
        newsVC.view.frame = CGRect(x: screen_width, y: 0, width: screen_width, height: vcHeight )
        self.detailView.scrollView.frame = self.newsVC.view.frame
        self.detailView.scrollView.addSubview(self.newsVC.view)
        self.newsVC.didMove(toParent: self)
        
//        self.musicVC = StatsVC.instantiate(fromAppStoryboard: .Main)
//        self.addChild(self.musicVC)
//        self.musicVC.view.frame = CGRect(x: 2 * screen_width, y: 0, width: screen_width, height: vcHeight )
//        self.detailView.scrollView.frame = self.musicVC.view.frame
//        self.detailView.scrollView.addSubview(self.musicVC.view)
//        self.musicVC.didMove(toParent: self)
//        
//        self.socialVC = StatsVC.instantiate(fromAppStoryboard: .Main)
//        self.addChild(self.socialVC)
//        self.socialVC.view.frame = CGRect(x: 3 * screen_width, y: 0, width: screen_width, height: vcHeight )
//        self.detailView.scrollView.frame = self.socialVC.view.frame
//        self.detailView.scrollView.addSubview(self.socialVC.view)
//        self.socialVC.didMove(toParent: self)
//        
//        self.eventsVC = StatsVC.instantiate(fromAppStoryboard: .Main)
//        self.addChild(self.eventsVC)
//        self.eventsVC.view.frame = CGRect(x: 4 * screen_width, y: 0, width: screen_width, height: vcHeight )
//        self.detailView.scrollView.frame = self.eventsVC.view.frame
//        self.detailView.scrollView.addSubview(self.eventsVC.view)
//        self.eventsVC.didMove(toParent: self)
//        
        
        self.detailView.scrollView.delegate = self
        
        self.configureScrollView()
        
    }
    
    
    private func buttonTapAction(senderTag: Int ) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.1) {
            self.detailView.scrollView.setContentOffset(CGPoint(x: screen_width * CGFloat(senderTag), y: 0), animated: true)
            self.headerView.detailImgView.forEach { (btn) in
                if btn.tag == senderTag{
                    self.headerView.detailImgView[senderTag].alpha = 1.0
                    self.headerView.detailBtn[senderTag].alpha = 1.0
                    self.headerView.detailBtn[senderTag].alpha = 1.0
                    self.headerView.detailBtn[senderTag].backgroundColor = .blue
                    self.headerView.detailBtn[senderTag].setTitleColor(.white, for: .normal)
                }else{
                    self.headerView.detailImgView[btn.tag].alpha = 0.0
                    self.headerView.detailBtn[btn.tag].alpha = 0.70
                    self.headerView.detailBtn[btn.tag].backgroundColor = .white
                    self.headerView.detailBtn[btn.tag].setTitleColor(.blue, for: .normal)
                }
            }
            self.view.layoutIfNeeded()
        }
        
    }
}



//MARK:- OtherArtistHeaderViewDelegate
//===================================

extension HomeComingVC : OtherArtistHeaderViewDelegate {
    func otherInfomation() {
        
    }
    func detailBtnAction(sender: UIButton) {
        self.buttonTapAction(senderTag: sender.tag)
    }
}


//MARK:- Move the screen and pages accroding to scroll
//====================================================

extension HomeComingVC {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.detailView.scrollView {
            print("DetailView ScrollView.contentOffset.y:- \(self.detailView.scrollView.contentOffset.y)")
            switch scrollView.contentOffset.x {
            case screen_width * 0:
                self.buttonTapAction(senderTag: 0)
            case screen_width * 1:
                self.buttonTapAction(senderTag: 1)
            case screen_width * 2:
                self.buttonTapAction(senderTag: 2)
            case screen_width * 3:
                self.buttonTapAction(senderTag: 3)
            case screen_width * 4:
                self.buttonTapAction(senderTag: 4)
            default:
                break
            }
        }
        if scrollView.contentOffset.y > 894.0{
            self.statsVC.mainTableView.isScrollEnabled = true
            self.newsVC.mainTableView.isScrollEnabled = true
        }
        print("Outer ScrollView.contentOffset.y:- \(scrollView.contentOffset.y)")
        if UIDevice.current.hasNotch {
            //... consider notch
        } else {
            //... don't have to consider notch
        }
    }
    
}


//MARK:- UINavigationItem
//======================

extension HomeComingVC {
    
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

