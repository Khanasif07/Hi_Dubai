//
//  AppRouter.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import Foundation
import UIKit
enum AppRouter {
    static func checkAppInitializationFlow(_ window: UIWindow) {
        goToNewsVC(window)
    }
    
    static func goToNewsVC(_ window: UIWindow){
        let scene = NewsListVC.instantiate(fromAppStoryboard: .Main)
        setAsWindowRoot(scene,window)
    }
    
    // MARK: - General Method to set Root VC
    //=========================================
    static func setAsWindowRoot(_ viewController: UIViewController,_ window: UIWindow) {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.hidesBarsOnSwipe = false
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension UIViewController{
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(self)
    }
    
    class var storyboardID : String {
        return "\(self)"
    }
}

enum AppStoryboard : String {
    case Main
}
extension AppStoryboard {
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    func viewController<T : UIViewController>(_ viewControllerClass : T.Type,
                        function : String = #function, // debugging purposes
                        line : Int = #line,
                        file : String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

//extension UIWindow {
//    static var key: UIWindow? {
//        if #available(iOS 13, *) {
//            return UIApplication.shared.windows.first { $0.isKeyWindow }
//        } else {
//            return UIApplication.shared.keyWindow
//        }
//    }
//}
