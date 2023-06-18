//
//  NavigationTypeVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 18/06/2023.
//

import UIKit

class NavigationTypeVC: UIViewController {
    
    //
    @IBOutlet weak var searchTxtFld: NewSearchTextField!
    @IBOutlet weak var gradientTopDistance: NSLayoutConstraint!
    @IBOutlet weak var gradientHeight: NSLayoutConstraint!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var scrollViewTopDistance: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var baseViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    //
    var gradient_MIN_HEIGHT: CGFloat = 0.0
    var gradient_MAX_HEIGHT: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let swipeGesture:UISwipeGestureRecognizer! = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .up
        swipeGesture.delegate = self
        self.scrollView?.addGestureRecognizer(swipeGesture)
        let swipeGestureD:UISwipeGestureRecognizer! = UISwipeGestureRecognizer(target:self, action:#selector(handleSwipeGesture(_:)))
        swipeGestureD.direction = .down
        swipeGestureD.delegate = self
        self.scrollView?.addGestureRecognizer(swipeGestureD)
        //
        initUI()
        //type1()
        //type2()
        //type3()
        //type4()
        //type5()
        //type6()
    }
    //Change “barTintColor”, “tintColor”
    private func type1(){
        self.navigationItem.title = "Type1"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .cyan
        self.navigationController?.navigationBar.tintColor = .brown
    }
    //Set setBackgroundImage, shadowImage
    private func type2(){
        self.navigationItem.title = "Type2"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Banner2"), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "Banner")
    }
    //Set Title and customize title color
    private func type3(){
        self.navigationItem.title = "Type3"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    //Set an image as navbar title
    private func type4(){
        self.navigationItem.title = "Type4"
        let logo = UIImage(named: "HiDubai_Logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    //Clear your navbar background
    private func type5(){
        self.navigationItem.title = "Type5"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    //Customize the back button. Remove the title of the back button and set the color.
    private func type6(){
        self.navigationItem.title = "Type6"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Type6", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.blue
    }
}

extension NavigationTypeVC: UIGestureRecognizerDelegate{
    func initUI(){
        if self.navBar != nil {
            let secondChildVC = RecentSearchVC.instantiate(fromAppStoryboard: .Main)
            if children.count == 0 {
                secondChildVC.view.frame = containerView.bounds
                containerView?.addSubview(secondChildVC.view)
                addChild(secondChildVC)
            }
        }
    }
    
    @objc func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        let scrollViewBottomEdge:CGFloat = self.scrollView!.contentOffset.y + CGRectGetHeight(self.scrollView!.frame)
        //Gesture detect - swipe up/down , can be recognized direction
        let _childScrollView = (self.children.first?.view.subviews.first as? PlacesAndSuperShesView)?.dataTableView
        if sender.direction == .up
        {
            print("Direction UP")
            
            if scrollViewBottomEdge >= self.scrollView!.contentSize.height && (_childScrollView)!.contentOffset.y == 0.00 && _childScrollView!.frame.size.height < _childScrollView!.contentSize.height {
                _childScrollView!.isScrollEnabled = true
                _childScrollView!.setContentOffset(CGPointMake(0, min(_childScrollView!.contentSize.height - _childScrollView!.frame.size.height , 200)), animated:true)
                //            }
            }
            else if sender.direction == .down
            {
                print("Direction DOWN")
                if scrollViewBottomEdge >= self.scrollView!.contentSize.height && _childScrollView!.contentOffset.y == 0.00 && _childScrollView!.isScrollEnabled {
                    _childScrollView!.isScrollEnabled = false
                    self.scrollView!.setContentOffset(CGPointMake(0, max(self.scrollView!.contentOffset.y-400,100)),animated:true)
                }
            }}
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            let topInset: CGFloat =  window?.safeAreaInsets.top ?? UIApplication.shared.statusBarFrame.size.height
            gradient_MAX_HEIGHT = 90 + (window?.safeAreaInsets.top ?? 0.0)
            baseViewHeight.constant = screen_height - (window?.safeAreaInsets.top ?? 0.0)
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            let topInset: CGFloat =  window?.safeAreaInsets.top ?? UIApplication.shared.statusBarFrame.size.height
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
