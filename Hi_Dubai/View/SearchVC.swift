//
//  SearchVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 04/05/2023.
//

import UIKit

class SearchVC: BaseVC{

    @IBOutlet weak var searchTxtFld: NewSearchTextField!
    @IBOutlet weak var peopleSearchBtn: UIButton!
    @IBOutlet weak var businessSearchBtn: UIButton!
    @IBOutlet weak var listsSearchBtn: UIButton!
    @IBOutlet weak var gradientTopDistance: NSLayoutConstraint!
    @IBOutlet weak var gradientHeight: NSLayoutConstraint!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var scrollViewTopDistance: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var baseViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var gradient_MIN_HEIGHT: CGFloat = 0.0
    var gradient_MAX_HEIGHT: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTxtFld.isHidden = true
        setColorsOfSelectedButton(businessSearchBtn)
        setColorsOfDefaultButton(listsSearchBtn)
        setColorsOfDefaultButton(peopleSearchBtn)

        // 44 is the assumed nav bar height
        
        scrollView.delegate = self

        gradient_MIN_HEIGHT = 64.0
        gradient_MAX_HEIGHT = 134.0 - 44.0
        // Do any additional setup after loading the view.
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            gradientHeight.constant = gradient_MAX_HEIGHT + (window?.safeAreaInsets.top ?? 0.0)
            //self.searchGradientTopDistance.constant = -(window.safeAreaInsets.top);
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.isScrollEnabled = false
        initUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            let topInset: CGFloat =  window?.safeAreaInsets.top ?? UIApplication.shared.statusBarFrame.size.height
            print("safeAreaInsets.top =\(window?.safeAreaInsets.top ?? 0.0)")
            print("safeAreaInsets.scrollViewTopDistance =\(scrollViewTopDistance.constant)")
            print("safeAreaInsets.screen szie =\(UIScreen.main.nativeBounds.size.height)")
//            scrollViewTopDistance.constant = window?.safeAreaInsets.top ?? 0.0
//            gradientTopDistance.constant = -((window?.safeAreaInsets.top) ?? 0.0)
//            gradient_MIN_HEIGHT = 64 + (window?.safeAreaInsets.top ?? 0.0)
            gradient_MAX_HEIGHT = 90 + (window?.safeAreaInsets.top ?? 0.0)
            baseViewHeight.constant = screen_height - (window?.safeAreaInsets.top ?? 0.0)
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            let topInset: CGFloat =  window?.safeAreaInsets.top ?? UIApplication.shared.statusBarFrame.size.height
            print("safeAreaInsets.top =\(window?.safeAreaInsets.top ?? 0.0)")
            print("safeAreaInsets.scrollViewTopDistance =\(scrollViewTopDistance.constant)")
            print("safeAreaInsets.screen szie =\(UIScreen.main.nativeBounds.size.height)")
            scrollViewTopDistance.constant = window?.safeAreaInsets.top ?? 0.0
            gradientTopDistance.constant = -((window?.safeAreaInsets.top) ?? 0.0)
            gradient_MIN_HEIGHT = 64 + (window?.safeAreaInsets.top ?? 0.0)
            gradient_MAX_HEIGHT = 90 + (window?.safeAreaInsets.top ?? 0.0)
        }
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setColorsOfSelectedButton(_ button: UIButton?) {
        button?.borderColor = UIColor.white
        button?.backgroundColor = UIColor.white
        button?.setTitleColor(UIColor.blue, for: .normal)
    }
    
    func showFilterVC(_ vc: BaseVC, index: Int? = nil) {
        if let obj = UIApplication.topViewController() {
            let ob = HotelFilterVC.instantiate(fromAppStoryboard: .Main)
//            ob.delegate = vc as? HotelFilteVCDelegate
            if let idx = index {
                ob.selectedIndex = idx
            }
            (obj).add(childViewController: ob)
        }
    }
    
    func setColorsOfDefaultButton(_ button: UIButton?) {
        button?.borderColor = UIColor.clear
        button?.backgroundColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2)
        button?.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func filterBtnAction(_ sender: UIButton) {
        showFilterVC(self)
    }
    
    @IBAction func tabAction(_ sender: UIButton) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        switch sender.tag {
        case 1:
            setColorsOfSelectedButton(businessSearchBtn)
            setColorsOfDefaultButton(listsSearchBtn)
            setColorsOfDefaultButton(peopleSearchBtn)
            if children.count == 1 || !(children[0] is NewsListVC){
                let secondChildVC = NewsListVC.instantiate(fromAppStoryboard: .Main)
                secondChildVC.isShowSectionHeader = true
                secondChildVC.headerTitle = "POPULAR BUSINESS"
                secondChildVC.containerViewMinY = Float(containerView?.frame.minY ?? 0.0)
                removeChildrenVC()
                secondChildVC.view.frame = containerView.bounds
                containerView?.addSubview(secondChildVC.view)
                addChild(secondChildVC)
            }
            
        case 2:
            setColorsOfSelectedButton(listsSearchBtn)
            setColorsOfDefaultButton(businessSearchBtn)
            setColorsOfDefaultButton(peopleSearchBtn)
            if children.count == 1 || !(children[0] is NewsListVC) {
                let secondChildVC = NewsListVC.instantiate(fromAppStoryboard: .Main)
                secondChildVC.isShowSectionHeader = true
                secondChildVC.headerTitle = "POPULAR LISTS"
                removeChildrenVC()
                secondChildVC.view.frame = containerView.bounds
                containerView?.addSubview(secondChildVC.view)
                addChild(secondChildVC)
            }
        default:
            setColorsOfSelectedButton(peopleSearchBtn)
            setColorsOfDefaultButton(businessSearchBtn)
            setColorsOfDefaultButton(listsSearchBtn)
            if  children.count == 1 || !(children[0] is NewsListVC){
                let secondChildVC = NewsListVC.instantiate(fromAppStoryboard: .Main)
                secondChildVC.headerTitle = "POPULAR PEOPLE"
                secondChildVC.isShowSectionHeader = true
                removeChildrenVC()
                secondChildVC.view.frame = containerView.bounds
                containerView?.addSubview(secondChildVC.view)
                addChild(secondChildVC)
            }
        }
        
    }
    
    func initUI(){
        if self.navBar != nil {
            let secondChildVC = NewsListVC.instantiate(fromAppStoryboard: .Main)
            secondChildVC.isShowSectionHeader = true
//            secondChildVC.containerViewMinY = Float(containerView?.frame.minY ?? 0.0)
            
            if children.count == 0 {
                removeChildrenVC()
                secondChildVC.view.frame = containerView.bounds
                containerView?.addSubview(secondChildVC.view)
                addChild(secondChildVC)
            }
        }
    }
    
    func removeChildrenVC() {
        for vc in children {
            vc.removeFromParent()
        }
        
        for view in containerView?.subviews ?? [] {
            view.removeFromSuperview()
        }

    }

    
    @objc func enableScrolling(_ offset: CGFloat,_ isSearchHidden: Bool = true) {
        scrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
        baseViewHeight.constant = scrollView.frame.size.height + offset
        // New Logic
        var isProcess: Bool = false
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            if isSearchHidden{
                gradient_MAX_HEIGHT = 90.0
                if !self.searchTxtFld.isHidden && !isProcess{
                    isProcess = true
                    //MARK: - commented for displaying search text field animation
//                    UIView.animate(withDuration: 0.25) {
//                        self.searchTxtFld.isHidden = isSearchHidden
//                        self.gradientHeight.constant = self.gradient_MAX_HEIGHT + (window?.safeAreaInsets.top ?? 0.0)
//                        isProcess = false
//                        self.view.layoutIfNeeded()
//                    }
                }
            }else{
                gradient_MAX_HEIGHT = 134.0
                if self.searchTxtFld.isHidden && !isProcess{
                    isProcess = true
                    //MARK: - commented for displaying search text field animation
//                    UIView.animate(withDuration: 0.25) {
//                        self.gradientHeight.constant = self.gradient_MAX_HEIGHT + (window?.safeAreaInsets.top ?? 0.0)
//                        self.searchTxtFld.isHidden = isSearchHidden
//                        isProcess = false
//                        self.view.layoutIfNeeded()
//                    }
                }
            }
            //self.searchGradientTopDistance.constant = -(window.safeAreaInsets.top);
        }
        print("----================----")
        print("Offset:- \(offset)")
        print("BaseViewHeight:- \(baseViewHeight.constant)")
        print("ScrollView Content Size:- \(scrollView.contentSize)")
        print("ScrollView Frame Size Height:- \(scrollView.frame.size.height)")
        print("ScrollView Content Offset Y:- \(scrollView.contentOffset.y)")
        
    }

}
