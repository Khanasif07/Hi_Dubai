//
//  AppFonts.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 05/05/2023.
//

import Foundation
import UIKit

enum AppFonts: String {
    
    case Light = "SourceSansPro-Light"
    case BoldItalic = "SourceSansPro-BoldItalic"
    case LightItalic = "SourceSansPro-LightItalic"
    case Regular = "SourceSansPro-Regular"
    case Italic = "SourceSansPro-Italic"
    case ExtraLight = "SourceSansPro-ExtraLight"
    case BlackItalic = "SourceSansPro-BlackItalic"
    case SemiBoldItalic = "SourceSansPro-SemiBoldItalic"
    case c = "SourceSansPro-Bold"
    case Bold = "SourceSansPro-SemiBoldd"
    case SemiBold = "SourceSansPro-SemiBold"
    case Black = "SourceSansPro-Black"
    case ExtraLightItalic = "SourceSansPro-ExtraLightItalic"
}

enum DeviceType {
    case iPhone5, iPhone6, iPhonePlusSize, iPadMini, iPad_10inch, iPad_12inch
}

extension AppFonts{
    
    func withSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}
