//
//  RoundedView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 16/05/2023.
//

import Foundation
import UIKit
@IBDesignable
class RoundedView : UIView {

    @IBInspectable private var _cornerRadius: CGFloat = 0.0
    @IBInspectable override var cornerRadius: CGFloat {
        get { return _cornerRadius }
        set(cornerRadius) {
            _cornerRadius = cornerRadius
            self.updateView()
        }
    }
    @IBInspectable private var _borderWidth: CGFloat = 0.0
    @IBInspectable override var borderWidth: CGFloat {
        get { return _borderWidth }
        set(borderWidth) {
            _borderWidth = borderWidth
            self.updateView()
        }
    }
    @IBInspectable private var _borderColor: UIColor! = UIColor.separator
    @IBInspectable override var borderColor: UIColor! {
        get { return _borderColor }
        set(borderColor) {
            _borderColor = borderColor
            self.updateView()
        }
    }
    @IBInspectable private var _circleBorder: Bool = true
    @IBInspectable var circleBorder: Bool {
        get { return _circleBorder }
        set(circleBorder) {
            _circleBorder = circleBorder
            self.updateView()
        }
    }

    // `setCornerRadius:` has moved as a setter.

    // `setBorderWidth:` has moved as a setter.

    // `setBorderColor:` has moved as a setter.

    // `setCircleBorder:` has moved as a setter.

    func updateView() {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = self.cornerRadius > 0
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
        if !self.borderColor.isEqual(UIColor.clear) && !self.borderColor.isEqual(WalifTheme.defaultBlue()) {
            self.layer.borderColor = UIColor(named: "separatorColor")?.cgColor
        }
        if self.tag == 100 {
            self.layer.borderColor = UIColor.white.cgColor
        }
        if (self.circleBorder) {
            self.layer.cornerRadius = self.layer.frame.size.height/2
            self.layer.masksToBounds = true
        }
    }

    func drawRect(rect:CGRect) {
        super.draw(rect)
        self.updateView()
    }
}
