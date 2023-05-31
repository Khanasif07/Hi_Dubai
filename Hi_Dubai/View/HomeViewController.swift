//
//  HomeViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 27/05/2023.
//

import UIKit
class HomeViewController: BaseVC {
    
    var headerView = OtherArtistHeaderView.instanciateFromNib()
    var detailView = OtherArtistDetail.instanciateFromNib()
  
    var statsVC    : StatsVC!
    var newsVC     : StatsVC!
    var eventsVC   : StatsVC!
    var musicVC    : StatsVC!
    var socialVC   : StatsVC!
    var isProcess : Bool = false

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
        self.mainScrollView.contentSize = frame.size
        frame = CGRect(x: 0, y: 325, width: screen_width, height: screen_height)
        frame.size.height = frame.size.height - (325)
        self.detailView.frame = frame
        scrollFrameSetup()
    }
    
    private func scrollFrameSetup() {
        self.setTheFrameOfViews()
    }
    
    
    ///SET THE FRAME OF VIEWS
    private func setTheFrameOfViews() {

      let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 64
      let vcHeight = screen_height - (45+40+tabBarHeight)
        
        self.statsVC.view.frame = CGRect(x: 0, y: 0, width: screen_width, height: vcHeight)
        self.newsVC.view.frame = CGRect(x: screen_width, y: 0, width: screen_width, height: vcHeight)
        self.musicVC.view.frame = CGRect(x: screen_width * 2, y: 0, width: screen_width, height: vcHeight)
        self.socialVC.view.frame = CGRect(x: screen_width * 3, y: 0, width: screen_width, height: vcHeight)
        self.eventsVC.view.frame = CGRect(x: screen_width * 4, y: 0, width: screen_width, height: vcHeight)

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
        let parallexHeaderHeight = 250 + 44.0
        self.headerView.frame = CGRect(x: 0, y: 0, width: Int(screen_width), height: Int(parallexHeaderHeight))
        self.headerView.isUserInteractionEnabled = true
        self.mainScrollView.delegate = self
        self.headerView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.HeaderDataSetUp()
    }
    
    private func instantiateViewController() {
        self.mainScrollView.addSubview(self.detailView)
        self.mainScrollView.addSubview(headerView)
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 70
        let vcHeight = screen_height-(45+40+tabBarHeight)

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
        
        self.musicVC = StatsVC.instantiate(fromAppStoryboard: .Main)
        self.addChild(self.musicVC)
        self.musicVC.view.frame = CGRect(x: 2 * screen_width, y: 0, width: screen_width, height: vcHeight )
        self.detailView.scrollView.frame = self.musicVC.view.frame
        self.detailView.scrollView.addSubview(self.musicVC.view)
        self.musicVC.didMove(toParent: self)
        
        self.socialVC = StatsVC.instantiate(fromAppStoryboard: .Main)
        self.addChild(self.socialVC)
        self.socialVC.view.frame = CGRect(x: 3 * screen_width, y: 0, width: screen_width, height: vcHeight )
        self.detailView.scrollView.frame = self.socialVC.view.frame
        self.detailView.scrollView.addSubview(self.socialVC.view)
        self.socialVC.didMove(toParent: self)
        
        self.eventsVC = StatsVC.instantiate(fromAppStoryboard: .Main)
        self.addChild(self.eventsVC)
        self.eventsVC.view.frame = CGRect(x: 4 * screen_width, y: 0, width: screen_width, height: vcHeight )
        self.detailView.scrollView.frame = self.eventsVC.view.frame
        self.detailView.scrollView.addSubview(self.eventsVC.view)
        self.eventsVC.didMove(toParent: self)
        
        
        self.detailView.scrollView.delegate = self
        
        self.configureScrollView()
        
    }
    
    private func configureScrollView() {
        self.detailView.scrollView.contentSize = CGSize(width: screen_width * 5.0, height: 1.0)
    }
    
    
    private func buttonTapAction(senderTag: Int ) {
        self.isProcess = true
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
            self.detailView.frame.size.height =  screen_height - (325 - 55.0)
            self.view.layoutIfNeeded()
        }
        
    }
    

}
extension HomeViewController : OtherArtistHeaderViewDelegate{
    func detailBtnAction(sender: UIButton) {
        self.buttonTapAction(senderTag: sender.tag)
    }
    
    func otherInfomation() {
        
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
        
        if scrollView.isEqual(mainScrollView){
           self.setNavBar(mainScrollView)
           if self.mainScrollView.contentOffset.y > 0.0 {
                UIView.animate(withDuration: 0.1) {
                    print("MainScrollView .contentOffset.y:- \(self.mainScrollView.contentOffset.y)")
                    let offsett =  self.mainScrollView.contentOffset.y >= 180.0 ? 180.0 : self.mainScrollView.contentOffset.y
                    switch self.detailView.scrollView.contentOffset.x {
                    case screen_width * 0:
                        self.statsVC.mainTableView.setContentOffset(CGPoint(x: 0, y: offsett), animated: false)
                    case screen_width * 1:
                        self.newsVC.mainTableView.setContentOffset(CGPoint(x: 0, y: offsett), animated: false)
                    case screen_width * 2:
                        self.musicVC.mainTableView.setContentOffset(CGPoint(x: 0, y: offsett), animated: false)
                    case screen_width * 3:
                        self.socialVC.mainTableView.setContentOffset(CGPoint(x: 0, y: offsett), animated: false)
                    case screen_width * 4:
                        self.eventsVC.mainTableView.setContentOffset(CGPoint(x: 0, y: offsett), animated: false)
                    default:
                        break
                    }
                    self.detailView.frame.size.height =  screen_height - (325 + statusBarHeight - 55.0) + offsett
                    self.baseViewHeight.constant = screen_height + offsett
                    if self.mainScrollView.contentOffset.y >= 180.0 {
                        self.mainScrollView.setContentOffset(CGPoint(x: 0, y: 180.0), animated: false)
                    }
                }
           }else{
               self.mainScrollView.setContentOffset(CGPoint(x: 0, y: 0.0), animated: false)
           }
        }
    }
    
    @objc func enableScrolling(_ offset: CGFloat,_ isSearchHidden: Bool = true) {
        if !isProcess {
            mainScrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
            print("detailView ScrollView.contentOffset.y:- \(offset)")
            detailView.frame.size.height =  screen_height - (325 + statusBarHeight - 55.0) + offset
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
