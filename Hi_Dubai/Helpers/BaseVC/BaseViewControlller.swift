//
//  BaseViewControlller.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 10/05/2023.
//
import Foundation
import UIKit
import FirebaseAnalytics
@objc class BaseViewController : UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var navbar: UINavigationBar!
    
    var backBtnVisible:Bool?
    var showCloseX:Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        backBtnVisible = true
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil

    }

    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.setupNavBar()
    }

    override func viewWillDisappear(_ animated:Bool) {
        //reset navigation bar as FALSE
        super.viewWillDisappear(animated)

        //Fix issue PDCLI-681
//        if (self is ListsSavedInVC) {
//            self.navigationController?.navigationBar.isHidden = true
//        } else{
            self.navigationController?.navigationBar.isHidden = false
//        }
    }

    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }

    func setupNavBar() {
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.view.backgroundColor = UIColor.clear
        let backBarButton:UIBarButtonItem! = UIBarButtonItem(title:"", style:.done, target:self, action:nil)
        self.navigationItem.backBarButtonItem = backBarButton
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white ,NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 13)]
                                                                    
        if navbar != nil {
            self.navigationItem.hidesBackButton = true

            self.navbar.setBackgroundImage(UIImage(), for: .default)
            self.navbar.barStyle = .blackTranslucent
            self.navbar.setBackgroundImage(UIImage(), for: .default)
            self.navbar.shadowImage = UIImage()
            self.navbar.isTranslucent = true
            if  (self.navigationController?.viewControllers.count ?? 0 > 0) && (self != self.navigationController?.viewControllers[0]) && (backBtnVisible!) {
                var imageName:String! = ""
//                if (appDelegate.locale == appDelegate.ar) {
//                    imageName = "back_button_arabic.png"
//                }else{
                    imageName = "iconfinder_cross-24_103181"
//                }
                let backButton:UIBarButtonItem! = UIBarButtonItem(image: UIImage(named: imageName),
                                                                  style:.plain,
                                                                              target:self,
                                                                  action:#selector(backButtonOverrideAction(_:)))
                self.navbar.topItem?.leftBarButtonItem = backButton
            }else{
                self.navbar.topItem?.leftBarButtonItem = nil
            }
        }
        if showCloseX ?? false {
            let closeBtn:UIBarButtonItem! = UIBarButtonItem(image:UIImage(named: "x_icon_1_1.png"),
                                                            style:.plain,
                                                                          target:self,
                                                            action:#selector(dismissAction(_:)))
            if navbar != nil {
                self.navbar.topItem?.rightBarButtonItem = closeBtn
            }else{
                self.navigationController?.navigationBar.topItem?.rightBarButtonItem = closeBtn
            }
        }
        self.navigationController?.navigationBar.isHidden = (navbar != nil)

    }

     @objc func dismissAction(_ sender:Any) {
        self.dismiss(animated: true)
    }

    func hideBackBtn() {
        self.navbar.topItem?.leftBarButtonItem = nil
    }

    
    @objc func backButtonOverrideAction(_ sender:Any?) {
        self.navigationController?.popViewController(animated: true)
    }

    func getBottomSafeArea() -> CGFloat {
//        if #available(iOS 11.0, *) {
//            let window:UIWindow! = WalifUtils.getWindowsFirstObject()
//            let bottomPadding:CGFloat = window.safeAreaInsets.bottom
//            return bottomPadding
//        } else {
            return 0
//        }
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let isRootVC:Bool = (viewController == navigationController.viewControllers.first!)
        navigationController.interactivePopGestureRecognizer?.isEnabled = !isRootVC
    }
    
    func navigationController(_ navigationController:UINavigationController, didShow viewController:UIViewController, animated:Bool) {
        let isRootVC:Bool = (viewController == navigationController.viewControllers.first!)
        navigationController.interactivePopGestureRecognizer?.isEnabled = !isRootVC
    }


    // MARK: - TexField Delegate
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
