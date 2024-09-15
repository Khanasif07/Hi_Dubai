//
//  RoundedImageView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 07/06/2023.
//

import Foundation
import UIKit
@IBDesignable class RoundedImageView : UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.updateView()
    }
    
    @IBInspectable var corner_Radius: CGFloat = 0.0  {
        didSet{
            self.updateView()
        }
    }
    @IBInspectable var border_Width: CGFloat = 0.0  {
        didSet{
            self.updateView()
        }
    }
    @IBInspectable var border_Color: UIColor = .white {
        didSet{
            self.updateView()
        }
    }
    
    @IBInspectable var circle_Border: Bool = false {
        didSet{
            self.updateView()
        }
    }

    // `setCornerRadius:` has moved as a setter.

    // `setBorderWidth:` has moved as a setter.

    // `setBorderColor:` has moved as a setter.

    // `setCircleBorder:` has moved as a setter.

    func updateView() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.corner_Radius
        self.layer.masksToBounds = self.corner_Radius > 0
        self.layer.borderWidth = self.border_Width
        self.layer.borderColor = self.border_Color.cgColor
        if (self.circle_Border) {
            self.layer.cornerRadius = self.layer.frame.size.height/2
            self.layer.masksToBounds = true
        }
    }

    func setBounds(_ bounds:CGRect) {
        super.bounds = bounds
        self.updateView()
    }
}
