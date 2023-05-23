//
//  UserTagLabel.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 23/05/2023.
//

import Foundation
import UIKit
@IBDesignable class UserTagLabel : UILabel {
    
//    enum TagType: Int{
//        case NONE
//        case EXPERT
//        case REGULAR
//        case CELEBRITY
//    }

    @IBInspectable var type: CGFloat = 1.0
    func setType(type: Int){
        self.type = CGFloat(type)
//        self.drawRect(rect: frame)
    }

    @IBInspectable var usertype: String = "EXPERT"
    func setUserType(usertype: String){
        self.usertype = usertype
        self.drawRect(rect: frame)
    }

    func setCornerRadius(cornerRadius: CGFloat) {
        DispatchQueue.main.async {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0
        }
    }
    

    override var intrinsicContentSize: CGSize{
        var size:CGSize = super.intrinsicContentSize
        size.width  += 16
        size.height += 10
        self.setCornerRadius(cornerRadius: size.height/2.0)
        return size
    }
    override func invalidateIntrinsicContentSize() {
        super.invalidateIntrinsicContentSize()
    }

    // `setType:` has moved as a setter.

    // `setUsertype:` has moved as a setter.

    func drawRect(rect:CGRect) {
        super.draw(rect)
        self.text = self.usertype
        self.font = UIFont.boldSystemFont(ofSize: 14)
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.isHidden = false
        self.backgroundColor = WalifTheme.expertTagColor()
//        setCornerRadius(cornerRadius: 13.5)
//        setCornerRadius(cornerRadius: self.size.height/2)
        // implementato per CGFloat type
//        switch (TagType(rawValue: Int(type))) {
//        case .NONE:
//            self.isHidden = true
//            self.backgroundColor = UIColor.clear
//            break
//        case .EXPERT:
//            self.isHidden = false
//            self.backgroundColor = WalifTheme.expertTagColor()
//            self.text = "EXPERT"
//            break
//        case .CELEBRITY:
//            self.isHidden = false
//            self.backgroundColor = WalifTheme.celebTagColor()
//            self.text = "CELEBRITY"
//            break
//        default:
//            break
//        }
        
//        if usertype.caseInsensitiveCompare("NONE") == .orderedSame {
//            self.isHidden = true
//            self.backgroundColor = UIColor.clear
//        } else if usertype.caseInsensitiveCompare("EXPERT") == .orderedSame {
//            self.isHidden = false
//            self.backgroundColor = WalifTheme.expertTagColor()
//            self.text = usertype
//        } else if usertype.caseInsensitiveCompare("REGULAR") == .orderedSame {
//            self.isHidden = true
//            //[self setBackgroundColor:[WalifTheme influencerTagColor]];
//            //[self setText:@"REGULAR"];
//            self.backgroundColor = UIColor.clear
//        } else if usertype.caseInsensitiveCompare("CELEBRITY") == .orderedSame {
//            self.isHidden = false
//            self.backgroundColor = WalifTheme.celebTagColor()
//            self.text = usertype
//        }
    }

    class func getColorForType(type:String!) -> UIColor! {
        if type.caseInsensitiveCompare("NONE") == .orderedSame {
           return UIColor.clear
        } else if type.caseInsensitiveCompare("EXPERT") == .orderedSame {
            return WalifTheme.expertTagColor()
        } else if type.caseInsensitiveCompare("REGULAR") == .orderedSame {
            return UIColor.clear
        } else if type.caseInsensitiveCompare("CELEBRITY") == .orderedSame {
            return WalifTheme.celebTagColor()
        }
        return UIColor.clear
    }


//    func intrinsicContentSize() -> CGSize {
//        var size:CGSize = super.intrinsicContentSize
//        size.width  += 16
//        size.height += 10
//        return size
//    }
}

