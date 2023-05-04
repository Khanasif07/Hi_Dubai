//
//  BaseVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 01/05/2023.
//

import Foundation
import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}


class BaseVC: UIViewController {
    
    var statusbarView = UIView()
    
    var navTitle: String = ""
    var shouldChangeNavigationWhileScroll: Bool = false
    var shouldChangeNavigationWhileScrollWithNoChange: Bool = false
    
    var backButtonTitle = "Back"
    
    var setNavigationBarHidden = false {
        didSet{
            navigationController?.setNavigationBarHidden(setNavigationBarHidden, animated: true)
            navigationController?.interactivePopGestureRecognizer?.delegate = nil
        }
    }
    
    var setNavigationBarClear: Bool = true {
        didSet {
            if setNavigationBarClear {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                self.navigationController?.navigationBar.shadowImage = UIImage()
                self.navigationController?.navigationBar.tintColor = UIColor.white
                self.statusBarStyle = .lightContent
                self.navigationController?.navigationBar.isTranslucent = setNavigationBarClear
            } else {
                self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                self.navigationController?.navigationBar.shadowImage = nil
                self.navigationController?.navigationBar.tintColor = UIColor.black
                self.statusBarStyle = .darkContent
            }
        }
    }
    
    var setNavigationBarClearWhileScroll: Bool = true {
        didSet {
            if !setNavigationBarClearWhileScroll {
                self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                self.navigationController?.navigationBar.shadowImage = nil
                let navbar = self.navigationController?.navigationBar
                navbar?.tintColor = UIColor.black
                self.statusBarStyle = .darkContent
                self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
                self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black]
                self.navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
            } else {
                self.statusBarStyle = .lightContent
                self.navigationController?.navigationBar.tintColor = UIColor.white
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                self.navigationController?.navigationBar.shadowImage = UIImage()
                self.navigationController?.navigationBar.isTranslucent = true
                self.navigationController?.navigationBar.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: UIColor.clear]
                self.navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
            }
            
        }
    }
    
     var shouldChangeNavigationItem: Bool = false {
        didSet {
            if shouldChangeNavigationItem {
                self.navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
                self.statusBarStyle = .darkContent
            }
        }
    }
    
    var setNavigationTitleClear: Bool = true {
        didSet {
            self.navigationController?.navigationBar.titleTextAttributes = [
                       NSAttributedString.Key.foregroundColor: UIColor.clear]
        }
    }
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.noInternet), name: NSNotification.Name(rawValue: "noInternetConnection"), object: nil)
        
     //   self.privateInitialSetup()
        self.initialSetup()
        self.addBlurEffect()
        self.setupLayouts()
        self.registerNibs()
        self.setupFonts()
        self.setupColors()
        self.setupImages()
        self.setupTexts()
        self.AddViewToStatusBar()
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
                 NSAttributedString.Key.font: UIFont(name: "Regular", size: 15)]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        Router.shared.currentTabNavigation = self.navigationController
//        Router.shared.tabbar = self.tabBarController as? TabBarVC
        UINavigationBar.appearance().tintColor = UIColor.black
        self.configureNavigationBar()
        self.setupBackTitle()
        self.navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    
    @objc func keyboardWillShow(notification: Notification) {
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        
    }

    @objc func noInternet(notification : NSNotification) {
//        self.removeSpinner()
//        CommonFunctions.showToastWithMessage(msg: "No internet connection")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            /*HINT:
             Open your info.plist and insert a new key named "View controller-based status bar appearance" to NO
            */
            UIApplication.shared.statusBarStyle = statusBarStyle
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: PRIVATE TO BASEVC
    private func privateInitialSetup() {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font:  UIFont(name: "Regular", size: 15) ]
        }
    }
    
    // MARK: To be overridden methods
    ///Need not to call super
    func initialSetup() {
//        if let tabbarHeight = self.tabBarController?.tabBar.frame.height {
//            let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: tabbarHeight+40.0, right: 0)
//            for views in self.view.subviews {
//                if views.isKind(of: UITableView.self) {
//                    let view = views as! UITableView
//                    view.contentInset = adjustForTabbarInsets
//                    view.scrollIndicatorInsets = adjustForTabbarInsets
//                }
//            }
//        }
    }
    
    func setupFonts(){
        
    }
    
    func setupColors(){
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureNavigationBar() {
//        let navbar = self.navigationController?.navigationBar
//        navbar?.tintColor = UIColor.black
//        self.setNavigationBarClear = false
//        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
//        self.statusBarStyle = .darkContent
    }
    
    func setupImages() {
        
    }
    
    func setupTexts() {
        
    }
    
    func setupLayouts() {
        
    }
    
    func registerNibs() {
        
    }
    
    func setupBackTitle() {
        
    }
    
    // MARK: Public Methods
    final func setNavigationBar(title: String = "", subTitle: String = "", backButton : Bool = true, titleView : Bool = false, backButtonImage: UIImage? = #imageLiteral(resourceName: "arrowBack"), buttonTitle: String = "", largeTitles: Bool = false, leftTitle: String = "") {
        
        self.navigationItem.title = title
        
        self.privateInitialSetup()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font:  UIFont(name: "Regular", size: 15)]
        
        if backButton {
            let button = UIButton(type: .system)
            button.setImage(backButtonImage, for: .normal)
            button.setTitle(buttonTitle, for: .normal)
            button.sizeToFit()
            button.addTarget(self, action: #selector(self.backButtonTapped), for: .allEvents)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        }
        if titleView {
            //setting navigationItems
            let customTitleView = UIView()
            customTitleView.frame = CGRect(x: 0, y: 0, width: 70, height: 15)
           // let appTitleImage = UIImageView(image: #imageLiteral(resourceName: "icForyou"))
            let view = UIView()
            view.backgroundColor = .red
            view.frame = customTitleView.bounds
            customTitleView.addSubview(view)
            self.navigationItem.titleView = customTitleView
        }
        
        if !leftTitle.isEmpty {
            let longTitleLabel = UILabel()
            longTitleLabel.text = leftTitle
            longTitleLabel.font =  UIFont(name: "Regular", size: 15)
            longTitleLabel.sizeToFit()
            
            let leftItem = UIBarButtonItem(customView: longTitleLabel)
            self.navigationItem.leftBarButtonItem = leftItem
        }
        
    }
    
    
    func addRightButtonToNavigation(title : String? = nil, titleColor: UIColor = .black, image: UIImage? = nil, font: UIFont? = nil, tintColor: UIColor = .white){
        let rightButton = UIButton(type: .custom)
        if let title = title{
            rightButton.setTitle(title, for: .normal)
        }
        rightButton.setTitleColor(titleColor, for: .normal)
        if let providedFont = font {
            rightButton.titleLabel?.font =  providedFont
        } else {
            rightButton.titleLabel?.font =   UIFont(name: "Regular", size: 15)
        }
        if let image = image{
           // rightButton.tintColor = tintColor
            rightButton.setImage(image, for: .normal)
        }
        
        rightButton.addTarget(self, action: #selector(rightBarButtonTapped(_:)), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        navigationController?.navigationBar.shadowImage = UIImage() // removes bottom line
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func addLeftButtonToNavigation(title : String? = nil, titleColor: UIColor = .black, image:
        
        UIImage? = nil, font: UIFont? = nil){
        let leftButton = UIButton(type: .custom)
        
        if let title = title {
            leftButton.setTitle(title, for: .normal)
        }
        
        leftButton.setTitleColor(titleColor, for: .normal)
        
        if let providedFont = font {
            leftButton.titleLabel?.font =  providedFont
        } else {
            leftButton.titleLabel?.font =   UIFont(name: "Regular", size: 15)
        }
        
        if let image = image{
            leftButton.setImage(image, for: .normal)
        }
        leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        navigationController?.navigationBar.shadowImage = UIImage() // removes bottom line
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func rightBarButtonTapped(_ sender: UIButton){
        
    }
    
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    
    /** Taken from apple reference code
     Configures the navigation bar to use a transparent background
     (see-through but without any blur).
     */
    final func applyTransparentBackgroundToTheNavigationBar(_ opacity: CGFloat) {
        guard let navController = self.navigationController else {return}
        
        
        var transparentBackground: UIImage
        
        /*    The background of a navigation bar switches from being translucent
         to transparent when a background image is applied. The intensity of
         the background image's alpha channel is inversely related to the
         transparency of the bar. That is, a smaller alpha channel intensity
         results in a more transparent bar and vis-versa.
         
         Below, a background image is dynamically generated with the desired opacity.
         */
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1),
                                               false,
                                               navController.navigationBar.layer.contentsScale)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(red: 1, green: 1, blue: 1, alpha: opacity)
        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
        transparentBackground = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let navigationBarAppearance = self.navigationController!.navigationBar
        
        navigationBarAppearance.setBackgroundImage(transparentBackground, for: .default)
    }
    
   private func addBlurEffect() {
//        let bounds = self.navigationController?.navigationBar.bounds
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
//        visualEffectView.frame = bounds ?? CGRect.zero
//        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.navigationController?.navigationBar.addSubview(visualEffectView)

        // Here you can add visual effects to any UIView control.
        // Replace custom view with navigation bar in the above code to add effects to the custom view.
    }
}


//Scroll extension
extension BaseVC: UIScrollViewDelegate {
    
    func AddViewToStatusBar() {
        if #available(iOS 13.0, *) {
            statusbarView.backgroundColor = UIColor.clear
            view.addSubview(statusbarView)
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.red
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if shouldChangeNavigationWhileScroll {
//            self.navigationItem.title = self.navTitle
//            var offset = scrollView.contentOffset.y / 150
//            if offset > 0.05 {
//                offset = 0.05
//                self.setNavigationBarClearWhileScroll = false
//            } else {
//                self.setNavigationBarClearWhileScroll = true
//            }
//            self.shouldChangeNavigationItem = self.shouldChangeNavigationWhileScrollWithNoChange
//        }
    }
    
}
