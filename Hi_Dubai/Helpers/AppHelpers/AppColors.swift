//
//  AppColors.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 01/05/2023.
//

import Foundation
import UIKit

class AppColors : UIColor{
    
    private enum ColorName : String{
        
        case appLightTeal
        case appBlackColor
        case appWhiteFont243
        case appTextBlueColor35Disabled
        case textFieldUnderlineGrey
        case appRedColor
        case shadowColor
        case appDarkGreen
        case appPinkColor
        case backgroundPink
        case shadowColor197
        case appTextBlueColor35opacity78
        case graphHorizontal
        case graphVertical
        case appBlueDark
        case appBlueColor
        
        var name : String{
            return self.rawValue
        }
    }
    
    
    static let appLightTeal = UIColor(named: ColorName.appLightTeal.name)!
    static let appBlackColor = UIColor(named: ColorName.appBlackColor.name)!
    static let appWhiteFont243 = UIColor(named: ColorName.appWhiteFont243.name)!
    static let appTextBlueColor35Disabled = UIColor(named: ColorName.appTextBlueColor35Disabled.name)!
    static let textFieldUnderlineGrey = UIColor(named: ColorName.textFieldUnderlineGrey.name)!
    static let appRedColor = UIColor(named: ColorName.appRedColor.name)!
    static let shadowColor = UIColor(named: ColorName.shadowColor.name)!
    static let appDarkGreen = UIColor(named: ColorName.appDarkGreen.name)!
    static let appPinkColor = UIColor(named: ColorName.appPinkColor.name)!
    static let backgroundPink = UIColor(named: ColorName.backgroundPink.name)!
    static let shadowColor197 = UIColor(named: ColorName.shadowColor197.name)!
    static let appTextBlueColor35opacity78 = UIColor(named: ColorName.appTextBlueColor35opacity78.name)!
   
    static let appBlueDark = UIColor(named: ColorName.appBlueDark.name)!
    static let graphHorizontalColor = UIColor(named: ColorName.graphHorizontal.name)!
    static let graphVerticalColor = UIColor(named: ColorName.graphVertical.name)!
    static let appBlueColor = UIColor(named: ColorName.appBlueColor.name)!
    
}



extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int, alpha : CGFloat) {
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")
        assert(alpha >= 0 && alpha <= 1, "Invalid alpha component")
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    //Returns the color based on the given R,G,B and alpha values
    class func colorRGB(r:Int, g:Int, b:Int, alpha:CGFloat = 1)->UIColor{
        return UIColor(r: r, g: g, b: b, alpha: alpha)
    }
    

    struct AppColor {
        static let changeBlack     = UIColor.colorRGB(r: 64, g: 64, b: 64)
        static let changeBlue      = UIColor.colorRGB(r: 33, g: 100, b: 171)
        static let changeGray      = UIColor.colorRGB(r: 151, g: 151, b: 151)
        static let changeBlueDark  = UIColor.colorRGB(r: 15, g: 76, b: 130)
        static let changeDarkTeal  = UIColor.colorRGB(r: 0, g: 127, b: 142)
        static let changeLightTeal = UIColor.colorRGB(r: 1, g: 183, b: 203)
        static let arrowsGreen     = UIColor.colorRGB(r: 135, g: 236, b: 18)
        static let rrowsGreen2     = UIColor.colorRGB(r: 70, g: 127, b: 6)
        static let arrowsRed       = UIColor.colorRGB(r: 255, g: 0, b: 68)
        static let ruleGrey        = UIColor.colorRGB(r: 237, g: 237, b: 237)
        static let backgroundGrey3 = UIColor.colorRGB(r: 245, g: 245, b: 245)
        static let profileBorderColor =  UIColor.colorRGB(r: 161, g: 189, b: 205)
        static let lightTealColor = UIColor.colorRGB(r: 103, g: 244, b: 255)
        static let navigationColor = UIColor.colorRGB(r: 245, g: 244, b: 244)
        static let progressBarShadow = UIColor.colorRGB(r: 0, g: 0, b: 0, alpha: 0.2)
        static let graphBackground = UIColor.colorRGB(r: 245, g: 245, b: 245, alpha: 1.0)
        static let largeTitle = UIColor.colorRGB(r: 74, g: 74, b: 74)
        static let whiteAlpha = UIColor.colorRGB(r: 255, g: 255, b: 255, alpha: 0.6)
        static let graphTimeBlackColor = UIColor.colorRGB(r: 69, g: 90, b: 100)
        static let alertBtnColor  = UIColor.colorRGB(r: 164, g: 170, b: 179, alpha: 1.0)
        
        static let otherUserProfileGradientColors = [UIColor.init(r: 0, g: 0, b: 0, alpha: 0.43).cgColor,UIColor.init(r: 52, g: 60, b: 82, alpha: 0.0).cgColor,UIColor.init(r: 46, g: 51, b: 73, alpha: 0.0).cgColor,UIColor.init(r: 14, g: 19, b: 22, alpha: 1.0).cgColor]
        
        static let artistHeaderGradientColors = [UIColor.init(r: 44, g: 175, b: 205, alpha: 1.0).cgColor,UIColor.init(r: 15, g: 76, b: 130, alpha: 1.0).cgColor]
        
        static let progressBarColors = [UIColor.init(r: 33, g: 100, b: 171, alpha: 1.0),UIColor.init(r: 1, g: 183, b: 203, alpha: 1.0)]
        
         static let playlistGradientColor = [UIColor.init(r: 0, g: 0, b: 0, alpha: 0.43).cgColor,UIColor.init(r: 52, g: 60, b: 82, alpha: 0.0).cgColor,UIColor.init(r: 199, g: 72, b: 106, alpha: 0.0).cgColor,UIColor.init(r: 199, g: 72, b: 106, alpha: 1.0).cgColor]

        static let buttonGradientColors = [UIColor.init(r: 34, g: 131, b: 184, alpha: 1.0).cgColor,UIColor.init(r: 15, g: 76, b: 130, alpha: 1.0).cgColor]

    }

}

