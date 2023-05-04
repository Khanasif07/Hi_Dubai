//
//  AppGlobals.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit
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


