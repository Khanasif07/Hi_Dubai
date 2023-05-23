//
//  RoundedButton.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 22/05/2023.
//
import UIKit
import Foundation
@IBDesignable class RoundedButton : UIButton{
    
    @IBInspectable private var _cornerRadius: CGFloat = 0.0
    override var cornerRadius: CGFloat {
        get { return _cornerRadius }
        set(cornerRadius) {
            _cornerRadius = cornerRadius
            self.updateView()
        }
    }
    @IBInspectable private var _borderWidth: CGFloat = 0.0
    override var borderWidth: CGFloat {
        get { return _borderWidth }
        set(borderWidth) {
            _borderWidth = borderWidth
            self.updateView()
        }
    }
    @IBInspectable private var _borderColor: UIColor = .red
    override var borderColor: UIColor! {
        get { return _borderColor }
        set(borderColor) {
            _borderColor = borderColor
            self.updateView()
        }
    }
    @IBInspectable private var _circleBorder: Bool = true
    var circleBorder: Bool {
        get { return _circleBorder }
        set(circleBorder) {
            _circleBorder = circleBorder
            self.updateView()
        }
    }
    @IBInspectable var keyValue: NSMutableString!
    
    // `setCornerRadius:` has moved as a setter.
    
    // `setBorderWidth:` has moved as a setter.
    
    // `setBorderColor:` has moved as a setter.
    
    // `setCircleBorder:` has moved as a setter.
    
    func updateView() {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = self.cornerRadius > 0
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor?.cgColor
        if self.circleBorder {
            self.layer.cornerRadius = self.layer.frame.size.height/2
            self.layer.masksToBounds = true
        }
    }
    
    func drawRect(rect:CGRect) {
        super.draw(rect)
        self.updateView()
    }
}
