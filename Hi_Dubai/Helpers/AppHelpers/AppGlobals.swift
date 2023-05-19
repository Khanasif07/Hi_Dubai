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



// MARK:- UIDEVICE
//==================
extension UIDevice {
    
    static let size = UIScreen.main.bounds.size
    
    static let height = UIScreen.main.bounds.height
    
    static let width = UIScreen.main.bounds.width
    
    @available(iOS 11.0, *)
    static var bottomSafeArea = UIApplication.shared.keyWindow!.safeAreaInsets.bottom
    
    @available(iOS 11.0, *)
    static let topSafeArea = UIApplication.shared.keyWindow!.safeAreaInsets.top
    
    static func vibrate() {
        let feedback = UIImpactFeedbackGenerator.init(style: UIImpactFeedbackGenerator.FeedbackStyle.heavy)
        feedback.prepare()
        feedback.impactOccurred()
    }
    
//    static func MarkerTapVibrate() {
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
//    }
}

extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR = "iPhone XR"
        case iPhone_XSMax = "iPhone XS Max"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhones_4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax
        default:
            return .unknown
        }
    }
}

extension Bundle {
    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var bundleName: String? {
        return infoDictionary?["CFBundleName"] as? String
    }
}
