//
//  AppGlobals.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit
import Foundation
extension UIApplication {
    var currentWindow: UIWindow? {
        if #available(iOS 13.0, *) {
           return connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        }
    }
    
    class func getWindowsFirstObject() -> UIWindow! {
           //isMemberOfClass
           var windowRef:UIWindow! = UIApplication.shared.windows.first
           let windowList:[AnyObject]! = UIApplication.shared.windows
        for aWindow:AnyObject? in windowList {
            if ((aWindow?.isMember(of: UIWindow.self)) != nil) {
                let windowObj:UIWindow! = aWindow as? UIWindow
                if windowObj.isHidden == false {
                       windowRef = windowObj
                       break
                   }
               }
            }
           return windowRef
       }
    
    class func topViewController(base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

let screen_size  = UIScreen.main.bounds.size
let screen_width  = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height
let statusBarHeight: CGFloat = {
    var heightToReturn: CGFloat = 0.0
         for window in UIApplication.shared.windows {
             if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                 heightToReturn = height
             }
         }
    return heightToReturn
}()

func delay(seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}


