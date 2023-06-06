//
//  RoundedView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 16/05/2023.
//

import Foundation
import UIKit
@IBDesignable class RoundedView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.updateView()
    }
    
    override func prepareForInterfaceBuilder() {

    }
    
    @IBInspectable var corner_Radius: CGFloat = 0.0{
        didSet{
            self.layer.cornerRadius = self.corner_Radius
            self.layer.masksToBounds = self.corner_Radius > 0
        }
    }
    
    @IBInspectable var border_Width: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = self.border_Width
        }
    }
    
    @IBInspectable  var border_Color: UIColor = .red {
        didSet{
            self.layer.borderColor = self.border_Color.cgColor
        }
    }
    
    @IBInspectable  var circle_Border: Bool = false {
        didSet{
            if self.circle_Border {
                self.layer.cornerRadius = self.layer.frame.size.height/2
                self.layer.masksToBounds = true
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateView()
    }
    
    @IBInspectable var keyValue: NSMutableString!
    
    // `setCornerRadius:` has moved as a setter.
    
    // `setBorderWidth:` has moved as a setter.
    
    // `setBorderColor:` has moved as a setter.
    
    // `setCircleBorder:` has moved as a setter.
    
    func updateView() {
        self.layer.cornerRadius = self.corner_Radius
        self.layer.masksToBounds = self.corner_Radius > 0
        self.layer.borderWidth = self.border_Width
        self.layer.borderColor = self.border_Color.cgColor
        if self.circle_Border {
            self.layer.cornerRadius = self.layer.frame.size.height/2
            self.layer.masksToBounds = true
        }
    }
}

