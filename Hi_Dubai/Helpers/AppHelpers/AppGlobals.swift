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
