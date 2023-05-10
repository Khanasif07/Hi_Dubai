//
//  BaseViewControlller.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 10/05/2023.
//
import UIKit
import Foundation
class BaseViewController : UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet  var _navbar: UINavigationBar? = UINavigationBar()
    var navbar: UINavigationBar! {
        get { return _navbar }
        set { _navbar = newValue }
    }
    private var _backBtnVisible:Bool = false
    var backBtnVisible:Bool {
        get { return _backBtnVisible }
        set { _backBtnVisible = newValue }
    }
    private var _showCloseX:Bool = false
    var showCloseX:Bool {
        get { return _showCloseX }
        set { _showCloseX = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _backBtnVisible = true
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.setupNavBar()
    }
    
    override func viewWillDisappear(_ animated:Bool) {
        //reset navigation bar as FALSE
    }
    
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func setupNavBar() {
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.view.backgroundColor = UIColor.clear
        let backBarButton:UIBarButtonItem! = UIBarButtonItem(title:"", style: .done, target:self, action:nil)
        self.navigationItem.backBarButtonItem = backBarButton
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size:13)]
        if (_navbar != nil) {
            //            self.navigationItem?.backAction = true
            
            self.navbar.setBackgroundImage(UIImage(), for: .default)
//            self.navbar.barStyle. = .blackTranslucent
            self.navbar.isTranslucent = true
            self.navbar.setBackgroundImage(UIImage(), for: .default)
            self.navbar.shadowImage = UIImage()
            self.navbar.isTranslucent = true
            if  ((self.navigationController?.viewControllers.count ?? 0) > 0 && (self != self.navigationController?.viewControllers[0]) && _backBtnVisible) {
                var imageName:String! = ""
                //                if (appDelegate.locale == appDelegate.ar) {
                //                    imageName = "back_button_arabic.png"
                //                }else{
                imageName = "back_button.png"
                //                }
                let backButton:UIBarButtonItem! = UIBarButtonItem(image:UIImage(named: imageName),style: .plain,target:self,action:Selector(("backButtonOverrideAction:")))
                self.navbar.topItem?.leftBarButtonItem = backButton
            }else{
                if #available(iOS 16.0, *) {
                    self.navbar.topItem?.leftBarButtonItem?.isHidden = true
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        if _showCloseX {
            let closeBtn:UIBarButtonItem! = UIBarButtonItem(image:UIImage(named: "x_icon_1_1.png"),
                                                            style:.plain,
                                                            target:self,
                                                            action:Selector(("dismissAction:")))
            if _navbar == nil {
                self.navbar.topItem?.rightBarButtonItem = closeBtn
            }else{
                self.navigationController?.navigationBar.topItem?.rightBarButtonItem = closeBtn
            }
        }
        self.navigationController?.navigationBar.isHidden = _navbar == nil
    }

func dismissAction(sender:AnyObject!) {
    if #available(iOS 16.0, *) {
        self.navbar.topItem?.leftBarButtonItem?.isHidden = true
    } else {
        // Fallback on earlier versions
    }
}

func hideBackBtn() {
    if #available(iOS 16.0, *) {
        self.navbar.topItem?.leftBarButtonItem?.isHidden = true
    } else {
        // Fallback on earlier versions
    }
}

func backButtonOverrideAction(sender:AnyObject!) {
    self.navigationController?.popViewController(animated: true)
}

func getBottomSafeArea() -> CGFloat {
    if #available(iOS 11.0, *) {
        let window:UIWindow! = UIApplication.shared.currentWindow
        let bottomPadding:CGFloat = window.safeAreaInsets.bottom
        return bottomPadding
    } else {
        return 0
    }
}

    func navigationController(_ navigationController:UINavigationController!, didShow viewController:UIViewController!, animated:Bool) {
    let isRootVC:Bool = viewController == navigationController.viewControllers.first
    navigationController.interactivePopGestureRecognizer?.isEnabled = !isRootVC
}

    
// MARK: - TexField Delegate

    func textFieldShouldReturn(_ textField:UITextField!) -> Bool {
    textField.resignFirstResponder()
    return true
}
}
